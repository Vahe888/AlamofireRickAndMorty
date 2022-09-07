//
//  RickAndMortyViewController.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 05.09.22.
//

import UIKit

struct Constants {
    static var baseURL = "https://rickandmortyapi.com/api/character/?page=30" //name=rick&status=alive"

    static let leftDistanceToView: CGFloat = 40
    static let rightDistanceToView: CGFloat = 40
    static let minimumLineSpacing: CGFloat = 20
    
    static let itemWidth = (UIScreen.main.bounds.width - Constants.leftDistanceToView - Constants.rightDistanceToView - (Constants.minimumLineSpacing / 2)) / 1.5
}

class RickAndMortyViewController: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!

    private var characters = [Character]()
    private var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()

        fetchData(with: Constants.baseURL)
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = Constants.minimumLineSpacing
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        guard let collectionView = collectionView else {
            return
        }

        collectionView.contentInset = UIEdgeInsets(
            top: 0,
            left: Constants.leftDistanceToView,
            bottom: 0,
            right: Constants.rightDistanceToView
        )
        
        collectionView.register(
            RickAndMortyCollectionViewCell.self,
            forCellWithReuseIdentifier: RickAndMortyCollectionViewCell.identifier
        )
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.showsHorizontalScrollIndicator = false
                
        view.addSubview(collectionView)

        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 350).isActive = true
    }
    
    private func fetchData(with url: String) {
        AlamofireManager.shared.fetchData(with: url) { [weak self] result in
            switch result {
            case .success(let characters):
                print("Success to fetch data and get characters array")
                self?.characters = characters
                DispatchQueue.main.async {
                    self?.collectionView?.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}

extension RickAndMortyViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let character = characters[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RickAndMortyCollectionViewCell.identifier, for: indexPath) as? RickAndMortyCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: character)
                
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let charater = characters[indexPath.item]
        guard let detailViewController = storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController else {
            return
        }
        
        detailViewController.character = charater
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension RickAndMortyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.itemWidth, height: collectionView.frame.height * 0.9)
    }
}

