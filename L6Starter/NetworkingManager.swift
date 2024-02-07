//
//  NetworkingManager.swift
//  L6Starter
//
//  Created by Sam Friedman on 12/2/22.
//

import Foundation
import Alamofire


class NetworkingMananger {
    
    
    static let host = "http://34.145.197.23/"

    static func getAllSongs(completion: @escaping (SongResponse) -> Void) {
        let endpoint = "\(host)test/songs/"
        AF.request(endpoint, method: .get).validate().responseData { response in
            switch response.result {
            case .success(let data):
                let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                if let userResponse = try? jsonDecoder.decode(SongResponse.self, from: data) {
                    completion(userResponse)
                } else {
                    print("Failed to decode getAllSongs")
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

}
