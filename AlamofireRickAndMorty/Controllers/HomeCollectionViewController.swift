//
//  HomeCollectionViewController.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 18.08.22.
//

import UIKit
import Alamofire
import SDWebImage

class HomeCollectionViewController: UICollectionViewController {

    // Array for characters.
    var characters: [Character] = []
    
    // Base URL for requesting data.
    var baseURL = "https://rickandmortyapi.com/api/character"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AlamofireManager.shared.fetchData(with: baseURL) { [weak self] result in
            switch result {
            case .success(let characters):
                self?.characters = characters
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return characters.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let model = characters[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PosterCollectionViewCell.identifier, for: indexPath) as! PosterCollectionViewCell
    
        // Configure the cell
        cell.configure(with: model)
        return cell
    }
}
