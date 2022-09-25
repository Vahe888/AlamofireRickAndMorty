//
//  Constants.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 20.09.22.
//

import Foundation
import UIKit

struct Constants {
    static var baseRickAndMortyURL = "https://rickandmortyapi.com/api/"
    
    static var charactersURL = "https://rickandmortyapi.com/api/character/"
    static var locationsURL = "https://rickandmortyapi.com/api/location/"
    static var episodesURL = "https://rickandmortyapi.com/api/episode/"

    static let leftDistanceToView: CGFloat = 40
    static let rightDistanceToView: CGFloat = 40
    static let minimumLineSpacing: CGFloat = 20
    
    static let itemWidth = (UIScreen.main.bounds.width - Constants.leftDistanceToView - Constants.rightDistanceToView - (Constants.minimumLineSpacing / 2)) / 2
    
    static let DetailCharacterTableViewControllerIdentifier = "DetailCharacterTableViewController"
    static let DetailLocationTableViewControllerIdentifier = "DetailLocationTableViewController"

}
