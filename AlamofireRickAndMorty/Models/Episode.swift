//
//  Episode.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 20.09.22.
//

import Foundation

struct Episode: Decodable {
    let info: Info?
    let results: [ResultsEpisode]?
}

struct ResultsEpisode: Decodable {
    let id: Int					// The id of the character.
    let name: String?          	// The name of the character.
    let air_date: String?        	// The type or subspecies of the character.
    let episode: String?			//
    let characters: [String]    	//
    let url: String?            	// Link to the character's own URL endpoint.
    let created: String?        	// Time at which the character was created in the database.
}
