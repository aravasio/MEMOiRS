//
//  API.swift
//  memoirs
//
//  Created by Alejandro Ravasio on 18/03/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation
import Moya

typealias UserResponse = ((User?) -> ())
typealias UsersResponse = (([User]) -> ())
typealias AlbumsResponse = (([Album]) -> ())
typealias PhotosResponse = (([Photo]) -> ())

class API {
    // Moya provider. We use the provider to direct requests to their proper endpoints.
//    fileprivate static let provider = MoyaProvider<JSONPlaceholderTarget>(plugins: [NetworkLoggerPlugin(verbose: true)])
    fileprivate static let provider = MoyaProvider<JSONPlaceholderTarget>()

    
    private func JSONResponseDataFormatter(_ data: Data) -> Data {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData =  try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return prettyData
        } catch {
            return data // fallback to original data if it can't be serialized.
        }
    }
    
    
    /**
     Fetches a user with the given id. If it can't find one (empty response), returns nil.
     
     - Parameters:
         - id: the ID of the user we want to fetch.
         - completion: code-block to execute after successfully completing the call.
     
     - Returns: A User object if passed ID is valid. `nil` if otherwise.
     */
    static func getUser(id: Int, completion: @escaping UserResponse) {
        let target = JSONPlaceholderTarget.user(id: id)
        
        provider.request(target) { response in
            switch response {
            case let .success(result):
                do {
                    let results = try JSONDecoder().decode([User].self, from: result.data)
                    completion(results.first)
                } catch let error {
                    print(error)
                    completion(nil)
                }
                
            case let .failure(error):
                print(error)
                // this means there was a network failure - either the request
                // wasn't sent (connectivity), or no response was received (server
                // timed out). If the server responds with a 4xx or 5xx error, that
                // will be sent as a ".success"-ful response.
            }
        }
    }
    
    /**
     Fetches all users.
    
     - parameters:
         - completion: What to execute on success.
     
     - Returns: An array of Users. Array might be empty.
     */
    static func getAllUsers(completion: @escaping UsersResponse) {
        let target = JSONPlaceholderTarget.user(id: nil)
        
        provider.request(target) { response in
            switch response {
            case let .success(result):
                do {
                    let results = try JSONDecoder().decode([User].self, from: result.data)
                    completion(results)
                } catch let error {
                    print(error)
                }
                
            case let .failure(error):
                print(error)
                // this means there was a network failure - either the request
                // wasn't sent (connectivity), or no response was received (server
                // timed out).  If the server responds with a 4xx or 5xx error, that
                // will be sent as a ".success"-ful response.
            }
        }
    }
    
}
