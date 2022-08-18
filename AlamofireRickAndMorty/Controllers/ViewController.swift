//
//  ViewController.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 17.08.22.
//

import UIKit
import Alamofire
import SDWebImage

class ViewController: UIViewController {
    
    var characters: [Character] = []
    
    var baseURL = "https://rickandmortyapi.com/api/character"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchCharacters()
    }
    
    func fetchCharacters() {
        
        AF.request(baseURL)
            .validate()
            .responseDecodable(of: Characters.self) { [weak self] response in
                guard let characters = response.value else { return }
                
                self?.characters = characters.all
            }
    }
}

