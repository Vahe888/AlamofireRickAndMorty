//
//  Location.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 20.09.22.
//

import Foundation

struct Location: Decodable {
    let info: Info?
    let results: [ResultsLocation]?
}

struct ResultsLocation: Decodable {
    let id: Int             	// The id of the character.
    let name: String?       	// The name of the character.
    let type: String?      	// The type or subspecies of the character.
    let dimension: String?	//
    let residents: [String]	//
    let url: String?        	// Link to the character's own URL endpoint.
    let created: String?    	// Time at which the character was created in the database.
}
