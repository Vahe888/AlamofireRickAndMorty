//
//  AlamofireManager.swift
//  AlamofireRickAndMorty
//
//  Created by Vahe Israyelyan on 18.08.22.
//

import Foundation
import Alamofire

enum AlamofireManagerError: Error {
    case failedToGetRequest
}

final class AlamofireManager {
    
    static var shared = AlamofireManager()

    func fetchData(with url: String, completion: @escaping (Result<[Character], Error>) -> Void) {
        AF.request(url).validate().responseDecodable(of: Characters.self) { response in
            guard let characters = response.value else {
                completion(.failure(AlamofireManagerError.failedToGetRequest))
                return
            }
            completion(.success(characters.all))
        }
    }
}
