//
//  RickAndMortyLocationsViewController.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 20.09.22.
//

import UIKit

class RickAndMortyLocationsViewController: UIViewController {

    private var locations = [Location]()

    override func viewDidLoad() {
        super.viewDidLoad()

        getLocations(with: Constants.locationsURL)
    }
	
    private func getLocations(with url: String) {
        AlamofireManager.shared.getLocations(with: url) { [weak self] result in
            switch result {
            case .success(let locations):
                print("Success to fetch data and get locations array")
                self?.locations = locations
                print(self?.locations)

            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }

}
