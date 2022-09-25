//
//  CharacterViewModel.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 22.09.22.
//

import Foundation

struct CharacterViewModel {
    
    let result: ResultsCharacter
    
    init(_ result: ResultsCharacter) {
        self.result = result
    }
    
    var id: Int {
        return self.result.id ?? 0
    }
    var name: String {
        return self.result.name ?? ""
    }
    var status: Status {
        return self.result.status ?? .unknown
    }
    var species: String {
        return self.result.species ?? ""
    }
    var type: String {
        return self.result.type ?? ""
    }
    var gender: Gender {
        return self.result.gender ?? .unknown
    }
    var origin: Origin {
        return self.result.origin
    }
    var location: Location_ {
        return self.result.location
    }
    var image: String {
        return self.result.image ?? ""
    }
    var episode: [String] {
        return self.result.episode ?? [""]
    }
    
}

struct CharacterListViewModel {
    var resultList: [ResultsCharacter]
    
    func numberOfItemsInSection() -> Int {
        return resultList.count
    }
    
    func cellForItemAt(_ index: Int) -> CharacterViewModel {
        let character = resultList[index]
        return CharacterViewModel(character)
    }
    
    mutating func searchNotFound() {
        self.resultList = []
    }
}
