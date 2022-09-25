//
//  RickAndMortyEpisodesTableViewController.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 21.09.22.
//

import UIKit

class RickAndMortyEpisodesTableViewController: UITableViewController {

    private var episodes = [ResultsEpisode]()
    private var page = 1
    private var hasMoreContent = true
    private var episodeCount = 0
    
    var characters = [ResultsCharacter]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.insetsContentViewsToSafeArea = false
        getEpisodeCount()
        getEpisodes(page: page)
    }
    
    private func getEpisodes(page: Int) {
        AlamofireManager.shared.getEpisodes(in: page) { result in
            switch result {
            case .success(let episodes):
                if self.episodeCount - self.episodes.count < 20 {
                    self.hasMoreContent = false
                }
                self.episodes += episodes
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: Get Location Count
    private func getEpisodeCount() {
        AlamofireManager.shared.getEpisodeCount { result in
            switch result {
            case .success(let response):
                self.episodeCount = response?.info?.count ?? 0
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = (scrollView.contentSize.height) - 250
        let height = scrollView.frame.size.height
        if offsetY > contentHeight - height {
            guard hasMoreContent else {
                return
            }
            page += 1
            getEpisodes(page: page)
        }
    }


    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return episodes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let episode = episodes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RickAndMortyEpisodeCell", for: indexPath)
        cell.textLabel?.text = episode.name
        return cell
    }
    
    fileprivate func fetchCharactersFromEpisode(_ episode: ResultsEpisode) {
        for character in episode.characters {
            AlamofireManager.shared.getCharacter(with: character) { result in
                switch result {
                case .success(let character):
                    self.characters.append(character)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let episode = episodes[indexPath.row]
        
        fetchCharactersFromEpisode(episode)
        
        guard let detailEpisodeTableViewController = storyboard?.instantiateViewController(withIdentifier: Constants.DetailEpisodeTableViewControllerIdentifiew) as? DetailEpisodeTableViewController else {
            return
        }
        detailEpisodeTableViewController.episode = episode
        detailEpisodeTableViewController.characters = self.characters
        navigationController?.pushViewController(detailEpisodeTableViewController, animated: true)
    }
}

