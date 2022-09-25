//
//  RickAndMortyCharactersCollectionViewController.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 21.09.22.
//

import UIKit

class RickAndMortyCharactersCollectionViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var characterCollectionView: UICollectionView!
    
    // MARK: - Properties
    private var characterListViewModel: CharacterListViewModel!

    private var characters = [ResultsCharacter]()
    private var characterCount = 0
    private var hasMoreContent = true
    private var page = 1
    private var pageCount = 1

    private var searchList = [ResultsCharacter]()
    private var search = false
    private var searchText = ""

    // MARK: - Lyfe cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true

        searchBar.delegate = self
        
        characterCollectionView.delegate = self
        characterCollectionView.dataSource = self
        
        characterCollectionViewConfigure()
        getCharacterCount()
        getCharacters(page: page)
    }
    
    // MARK: - Private Functions
    
    // MARK: Collection View Configuration
    private func characterCollectionViewConfigure() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let characterCollectionViewWidth = self.characterCollectionView.frame.size.width
        let characterCollectionViewCellWidth = (characterCollectionViewWidth - 20) / 2
        
        layout.itemSize = CGSize(width: characterCollectionViewCellWidth,
                                 height: characterCollectionViewCellWidth)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        layout.minimumLineSpacing = 5
//        layout.minimumInteritemSpacing = 5
        
        characterCollectionView.collectionViewLayout = layout
        characterCollectionView.isPagingEnabled = true
    }
    
    // MARK: Get Characters
    private func getCharacters(page: Int) {
        AlamofireManager.shared.getCharacters(in: page) { result in
            switch result {
            case .success(let characters):
                if self.characterCount - self.characters.count < 20 {
                    self.hasMoreContent = false
                }
                self.characters += characters
                self.characterListViewModel = CharacterListViewModel(resultList: self.characters)
                DispatchQueue.main.async {
                    self.characterCollectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: Get Character Count
    private func getCharacterCount() {
        AlamofireManager.shared.getCharacterCount { result in
            switch result {
            case .success(let response):
                self.characterCount = response?.info?.count ?? 0
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Search Functions
    
    // MARK: Get Search Character Count
    func searchCharacterCount(searchText: String) {
        AlamofireManager.shared.searchCharacterCount(searchText: searchText) { result in
            switch result {
            case .success(let response):
                self.pageCount = response?.info?.pages ?? 0
            case .failure(let error):
            	print(error)
            }
        }
    }
    
    // MARK: Scroll View Function to detect bottom scrolling
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = (scrollView.contentSize.height) - 250
        let height = scrollView.frame.size.height
        if offsetY > contentHeight - height {
            guard hasMoreContent else {
                return
            }
            page += 1
            if self.search == false {
                getCharacters(page: page)
            }
            else {
                if page <= pageCount{
                    searchCharacter(page: page, self.searchText)
                }
            }
        }
    }
}

// MARK: - Extention for UI Collection View Delegate and Data Source
extension RickAndMortyCharactersCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterListViewModel == nil ? 0 : self.characterListViewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let characterViewModel = characterListViewModel.cellForItemAt(indexPath.row)

        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: RickAndMortyCharacterCollectionViewCell.identifier,
            for: indexPath) as? RickAndMortyCharacterCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: characterViewModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let charater = characterListViewModel.resultList[indexPath.item]

        guard let detailCharacterTableViewController = storyboard?.instantiateViewController(withIdentifier: Constants.DetailCharacterTableViewControllerIdentifier) as? DetailCharacterTableViewController else {
            return
        }
        detailCharacterTableViewController.character = charater
        navigationController?.pushViewController(detailCharacterTableViewController, animated: true)
    }
}

// MARK: - Extention for UI Search Bar Delegate
extension RickAndMortyCharactersCollectionViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        search = true
        searchCharacterCount(searchText: searchText)
        self.searchText = searchText
        self.searchList.removeAll(keepingCapacity: false)
        searchCharacter(page: 1, self.searchText)
        if searchText == "" {
            search = false
            page = 1
            characters.removeAll(keepingCapacity: false)
            getCharacters(page: page)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
    func searchCharacter(page: Int, _ searchText: String){
        AlamofireManager.shared.searchCharacterByName(page: page, searchText: searchText) { result in
			switch result {
            case .success(let characters):
                if characters.count > 0 {
                    self.searchList += characters
                    self.characterListViewModel = CharacterListViewModel(resultList: self.searchList)
                    DispatchQueue.main.async {
                        self.characterCollectionView.reloadData()
                    }
                }
            case .failure(_):
                self.characterListViewModel.searchNotFound()
                DispatchQueue.main.async {
                    self.characterCollectionView.reloadData()
                }
            }
        }
    }
}
