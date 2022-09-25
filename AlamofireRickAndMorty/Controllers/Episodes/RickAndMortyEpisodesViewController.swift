//
//  RickAndMortyEpisodesViewController.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 20.09.22.
//

import UIKit

class RickAndMortyEpisodesViewController: UIViewController {

    private var episodes = [Episode]()

    override func viewDidLoad() {
        super.viewDidLoad()

        getEpisodes(with: Constants.episodesURL)
    }
    
    private func getEpisodes(with url: String) {
        AlamofireManager.shared.getEpisodes(with: url) { [weak self] result in
            switch result {
            case .success(let episodes):
                print("Success to fetch data and get episodes array")
                self?.episodes = episodes
                print(self?.episodes)

            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }

}
