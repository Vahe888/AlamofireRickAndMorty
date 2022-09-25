//
//  AlamofireManager.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 18.08.22.
//

import Foundation
import Alamofire

enum AlamofireManagerError: Error {
    case failedToGetURL
    case failedToGetRequest
}

final class AlamofireManager {
    
    static var shared = AlamofireManager()
    private init() {}

    func getCharacters(with url: String, completion: @escaping (Result<[ResultsCharacter], Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(AlamofireManagerError.failedToGetURL))
            return
        }

        AF.request(url).validate().responseDecodable(of: Character.self) { response in
            guard let characters = response.value else {
                completion(.failure(AlamofireManagerError.failedToGetRequest))
                return
            }
            if let charactersResult = characters.results {
            	completion(.success(charactersResult))
            }
        }
    }
    
    // MARK: - Characters
    func getCharacters(in page: Int, completion: @escaping (Result<[ResultsCharacter], Error>) -> Void) {
        let urlCharacter = Constants.charactersURL + "?page=\(page)"
        guard let url = URL(string: urlCharacter) else {
            completion(.failure(AlamofireManagerError.failedToGetURL))
            return
        }
        
        AF.request(url).validate().responseDecodable(of: Character.self) { response in
            guard let characters = response.value else {
                completion(.failure(AlamofireManagerError.failedToGetRequest))
                return
            }
            if let charactersResult = characters.results {
                completion(.success(charactersResult))
            }
            else {
                completion(.failure(AlamofireManagerError.failedToGetRequest))
            }
        }
    }
    
    func getCharacterCount(completion: @escaping (Result<Character?, Error>) -> Void) {
        let urlCharacterCount = Constants.charactersURL
        guard let url = URL(string: urlCharacterCount) else {
            return
        }
        AF.request(url).validate().responseDecodable(of: Character.self) { response in
            guard let characters = response.value else {
                completion(.failure(AlamofireManagerError.failedToGetRequest))
                return
            }
            completion(.success(characters))
        }
    }
    
    // MARK: - Search
    func searchCharacterCount(searchText: String, completion: @escaping (Result<Character?, Error>) -> Void) {
        let urlSearchCharacterCount = Constants.charactersURL + "?name=\(searchText.replacingOccurrences(of: " ", with: "+"))"
        guard let url = URL(string: urlSearchCharacterCount) else {
            return
        }
        AF.request(url).validate().responseDecodable(of: Character.self) { response in
            guard let characters = response.value else {
                completion(.failure(AlamofireManagerError.failedToGetRequest))
                return
            }
            completion(.success(characters))
        }
    }
    
    func searchCharacterByName(page: Int, searchText: String, completion: @escaping (Result<[ResultsCharacter], Error>) -> Void) {
        let urlSearchCharacterByName = Constants.charactersURL + "?name=\(searchText.replacingOccurrences(of: " ", with: "+"))&page=\(page)"
        guard let url = URL(string: urlSearchCharacterByName)else{
            return
        }
        AF.request(url).validate().responseDecodable(of: Character.self) { response in
            guard let characters = response.value else {
                completion(.failure(AlamofireManagerError.failedToGetRequest))
                return
            }
            if let charactersResult = characters.results {
                completion(.success(charactersResult))
            }
            else {
                completion(.failure(AlamofireManagerError.failedToGetRequest))
            }
        }
    }
    
    // MARK: - Locations
    func getLocations(with url: String, completion: @escaping (Result<[ResultsLocation], Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(AlamofireManagerError.failedToGetURL))
            return
        }
        
        AF.request(url).validate().responseDecodable(of: Location.self) { response in
            guard let locations = response.value else {
                completion(.failure(AlamofireManagerError.failedToGetRequest))
                return
            }
            if let locationsResult = locations.results {
                completion(.success(locationsResult))
            }
        }
    }
    
    func getLocations(in page: Int, completion: @escaping (Result<[ResultsLocation], Error>) -> Void) {
        let urlLocation = Constants.locationsURL + "?page=\(page)"
        guard let url = URL(string: urlLocation) else {
            completion(.failure(AlamofireManagerError.failedToGetURL))
            return
        }
        
        AF.request(url).validate().responseDecodable(of: Location.self) { response in
            guard let locations = response.value else {
                completion(.failure(AlamofireManagerError.failedToGetRequest))
                return
            }
            if let locationsResult = locations.results {
                completion(.success(locationsResult))
            }
            else {
                completion(.failure(AlamofireManagerError.failedToGetRequest))
            }
        }
    }
    
    func getLocationCount(completion: @escaping (Result<Location?, Error>) -> Void) {
        let urlLocationCount = Constants.locationsURL
        guard let url = URL(string: urlLocationCount) else {
            return
        }
        AF.request(url).validate().responseDecodable(of: Location.self) { response in
            guard let locations = response.value else {
                completion(.failure(AlamofireManagerError.failedToGetRequest))
                return
            }
            completion(.success(locations))
        }
    }
    
    // MARK: - Episodes
    func getEpisodes(with url: String, completion: @escaping (Result<[ResultsEpisode], Error>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(AlamofireManagerError.failedToGetURL))
            return
        }
        
        AF.request(url).validate().responseDecodable(of: Episode.self) { response in
            guard let episodes = response.value else {
                completion(.failure(AlamofireManagerError.failedToGetRequest))
                return
            }
            if let episodesResult = episodes.results {
                completion(.success(episodesResult))
            }
        }
    }
    
    func getEpisodes(in page: Int, completion: @escaping (Result<[ResultsEpisode], Error>) -> Void) {
        let urlEpisode = Constants.episodesURL + "?page=\(page)"
        guard let url = URL(string: urlEpisode) else {
            completion(.failure(AlamofireManagerError.failedToGetURL))
            return
        }
        
        AF.request(url).validate().responseDecodable(of: Episode.self) { response in
            guard let episodes = response.value else {
                completion(.failure(AlamofireManagerError.failedToGetRequest))
                return
            }
            if let episodesResult = episodes.results {
                completion(.success(episodesResult))
            }
            else {
                completion(.failure(AlamofireManagerError.failedToGetRequest))
            }
        }
    }
    
    func getEpisodeCount(completion: @escaping (Result<Episode?, Error>) -> Void) {
        let urlEpisodeCount = Constants.episodesURL
        guard let url = URL(string: urlEpisodeCount) else {
            return
        }
        AF.request(url).validate().responseDecodable(of: Episode.self) { response in
            guard let episodes = response.value else {
                completion(.failure(AlamofireManagerError.failedToGetRequest))
                return
            }
            completion(.success(episodes))
        }
    }
}
