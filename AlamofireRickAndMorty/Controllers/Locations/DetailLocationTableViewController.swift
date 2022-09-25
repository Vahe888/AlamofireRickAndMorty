//
//  DetailLocationTableViewController.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 24.09.22.
//

import UIKit

class DetailLocationTableViewController: UITableViewController {
    
    var location: ResultsLocation?
    var character = [ResultsCharacter]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = location?.name
        navigationController?.navigationBar.tintColor = .label
        test()
        tableView.selectionFollowsFocus = true
    }
    
    private func test() {
        guard let location = location else {
            return
        }
        
        for item in location.residents {
            print(item)
            AlamofireManager.shared.getCharacters(with: item) { result in
                switch result {
                case .success(let character):
                    self.character.append(character.first!)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
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
        return location?.residents.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "INFO"
        }
        return "RESIDENTS"
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationInfoTableViewCell.identifier, for: indexPath) as? LocationInfoTableViewCell,
                  let location = location else {
                return UITableViewCell()
            }
            cell.configure(with: location, in: indexPath)
            
            return cell
        }
        else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LocationResidentTableViewCell.identifier, for: indexPath) as? LocationResidentTableViewCell, let location = location else {
                return UITableViewCell()
            }
            AlamofireManager.shared.getCharacters(with: location.residents[indexPath.row]) { result in
                switch result {
                case .success(let character):
                    DispatchQueue.main.async {
                        cell.residentNameLabel.text = character.first?.name ?? ""
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
            
            return cell
        }
    }
}
