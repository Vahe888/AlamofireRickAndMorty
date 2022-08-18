//
//  Character.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 18.08.22.
//

import Foundation

struct Character: Decodable {
    let id: Int
    let name: String?
    let type: String?
    let image: String?
    let gender: String?
    let species: String?
    let status: String?
}

struct Characters: Decodable {
    let all: [Character]
    
    enum CodingKeys: String, CodingKey {
        case all = "results"
    }
}
