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

    override func viewDidLoad() {
        super.viewDidLoad()

        getEpisodeCount()
        getEpisodes(page: page)
    }
    
    private func getEpisodes(page: Int) {
        AlamofireManager.shared.getEpisodes(in: page) { result in
            switch result {
            case .success(let episodes):
                print("Success to fetch data and get locations array")
                print(self.episodeCount - self.episodes.count)
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
                print(self.episodeCount)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = (scrollView.contentSize.height) - 100
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "RickAndMortyEpisodesCell", for: indexPath)
		
        cell.textLabel?.text = episode.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
