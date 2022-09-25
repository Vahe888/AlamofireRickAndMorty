//
//  Character.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 18.08.22.
//

import Foundation

struct Character: Decodable {
    let info: Info?
    var results: [ResultsCharacter]?
}

struct Info: Decodable {
    let count: Int?
    let pages: Int?
    let next: String?
    let prev: String?
}

struct ResultsCharacter: Decodable {
    let id: Int?             // The id of the character.
    let name: String?       	// The name of the character.
    let status: Status?     	// The status of the character ('Alive', 'Dead' or 'unknown').
    let species: String?    	// The species of the character.
    let type: String?       	// The type or subspecies of the character.
    let gender: Gender?     	// The gender of the character ('Female', 'Male', 'Genderless' or 'unknown').
    let origin: Origin     	// Name and link to the character's origin location.
    let location: Location_	// Name and link to the character's last known location endpoint
    let image: String?      	// Link to the character's image. All images are 300x300px and most are medium shots or 					portraits since they are intended to be used as avatars.
    let episode: [String]?	// List of episodes in which this character appeared.
    let url: String?        	// Link to the character's own URL endpoint.
    let created: String?    	// Time at which the character was created in the database.
}

enum Status: String, Decodable {
    case Alive
    case Dead
    case unknown
}

enum Gender: String, Decodable {
    case Female
    case Male
    case Genderless
    case unknown
}

struct Origin: Decodable {
    let name: String?
    let url: String?
}

struct Location_: Decodable {
    let name: String?
    let url: String?
}
