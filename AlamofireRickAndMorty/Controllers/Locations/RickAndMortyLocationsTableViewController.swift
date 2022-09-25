//
//  RickAndMortyLocationsTableViewController.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 21.09.22.
//

import UIKit

class RickAndMortyLocationsTableViewController: UITableViewController {

    private var locations = [ResultsLocation]()
	private var page = 1
    private var hasMoreContent = true
    private var locationCount = 0
    
//    var character = [ResultsCharacter]()

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.insetsContentViewsToSafeArea = false
        getLocationCount()
        getLocations(page: page)
    }
    
    private func getLocations(page: Int) {
        AlamofireManager.shared.getLocations(in: page) { result in
            switch result {
            case .success(let locations):
                if self.locationCount - self.locations.count < 20 {
                    self.hasMoreContent = false
                }
                self.locations += locations
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }

            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    // MARK: Get Location Count
    private func getLocationCount() {
        AlamofireManager.shared.getLocationCount { result in
            switch result {
            case .success(let response):
                self.locationCount = response?.info?.count ?? 0
                print(self.locationCount)
            case .failure(let error):
                print(error)
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
            getLocations(page: page)
        }
    }


    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return locations.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let location = locations[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "RickAndMortyLocationCell", for: indexPath)
        cell.textLabel?.text = location.name
                
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let location = locations[indexPath.row]

        guard let detailLocationTableViewController = storyboard?.instantiateViewController(withIdentifier: Constants.DetailLocationTableViewControllerIdentifier) as? DetailLocationTableViewController else {
            return
        }
        detailLocationTableViewController.location = location
        navigationController?.pushViewController(detailLocationTableViewController, animated: true)
    }
}
