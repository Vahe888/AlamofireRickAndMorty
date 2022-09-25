//
//  DetailLocationTableViewController.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 24.09.22.
//

import UIKit

class DetailEpisodeTableViewController: UITableViewController {
    
    var episode: ResultsEpisode?
    var characters: [ResultsCharacter]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = episode?.name
        navigationController?.navigationBar.tintColor = .label
        tableView.selectionFollowsFocus = true
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 2
        }
        return episode?.characters.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "INFO"
        }
        return "CHARACTERS"
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeInfoTableViewCell.identifier, for: indexPath) as? EpisodeInfoTableViewCell,
                  let episode = episode else {
                return UITableViewCell()
            }
            cell.configure(with: episode, in: indexPath)
            
            return cell
        }
        else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeCharacterTableViewCell.identifier, for: indexPath) as? EpisodeCharacterTableViewCell, let character = self.characters, !character.isEmpty else {
                return UITableViewCell()
            }
            cell.configure(with: character[indexPath.row], in: indexPath)
            return cell
        }
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            return
        }
        else {
            guard let character = characters?[indexPath.row] else {
                return
            }
                        
            guard let detaiCharacterTableViewController = storyboard?.instantiateViewController(withIdentifier: Constants.DetailCharacterTableViewControllerIdentifier) as? DetailCharacterTableViewController else {
                return
            }
            detaiCharacterTableViewController.character = character
            navigationController?.pushViewController(detaiCharacterTableViewController, animated: true)
        }
    }
}
