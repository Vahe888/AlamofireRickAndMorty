//
//  RickAndMortyViewController.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 05.09.22.
//

// MARK: - IMPORTANT - OLD VERSION OF CHARACTER VIEW CONTROLLER. SEE: RickAndMortyCharactersCollectionViewController

import UIKit

class RickAndMortyCharactersViewController: UIViewController {

    private var characters = [ResultsCharacter]()
    private var newURL: String = ""
    private var collectionView: UICollectionView?
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Page Number"
        textField.borderStyle = .roundedRect
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        setupTextField()

        getCharacters(with: Constants.charactersURL)
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
        collectionView.isPagingEnabled = true
                
        view.addSubview(collectionView)

        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: 350).isActive = true
    }
    
    private func setupTextField() {
        view.addSubview(textField)
        textField.delegate = self
        
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100).isActive = true
        textField.topAnchor.constraint(equalTo: collectionView!.bottomAnchor, constant: 20).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    private func getCharacters(with url: String) {
        AlamofireManager.shared.getCharacters(with: url) { [weak self] result in
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

extension RickAndMortyCharactersViewController: UICollectionViewDataSource {
    
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

        guard let detailCharacterTableViewController = storyboard?.instantiateViewController(withIdentifier: Constants.DetailCharacterTableViewControllerIdentifier) as? DetailCharacterTableViewController else {
            return
        }
        detailCharacterTableViewController.character = charater
        navigationController?.pushViewController(detailCharacterTableViewController, animated: true)
    }
}

extension RickAndMortyCharactersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: Constants.itemWidth, height: collectionView.frame.height * 0.85)
    }
}

extension RickAndMortyCharactersViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text, !text.isEmpty {
            newURL = "\(Constants.baseRickAndMortyURL)/character/?page=\(text)"
            print(newURL)
            getCharacters(with: newURL)
            self.collectionView?.reloadData()
        }
    }
}
