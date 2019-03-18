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
    
    private init() { }
    
    // Moya provider. We use the provider to direct requests to their proper endpoints.
    //    internal static let provider = MoyaProvider<Endpoint>(plugins: [NetworkLoggerPlugin(verbose: true)])
    internal static let provider = MoyaProvider<Endpoint>()
    
    
    
    /**
     Fetches a user with the given id. If it can't find one (empty response), returns nil.
     
     - Parameters:
     - id: the ID of the user we want to fetch.
     - completion: code-block to execute after successfully completing the call.
     
     - Returns: A User object if passed ID is valid. `nil` if otherwise.
     */
    static func getUser(id: Int, completion: @escaping UserResponse) {
        let target = Endpoint.user(id: id)
        API.fetch(provider: provider, endpoint: target, returnType: [User].self, completion: { response in
            completion(response.first)
        })
    }
    
    
    /**
     Fetches all users.
     
     - parameters:
     - completion: What to execute on success.
     
     - Returns: An array of Users. Array might be empty.
     */
    static func getAllUsers(completion: @escaping UsersResponse) {
        let target = Endpoint.user(id: nil)
        API.fetch(provider: provider, endpoint: target, returnType: [User].self, completion: completion)
    }
    
    
    
    /**
     Fetches all Photos for a given albumId.
     
     - Parameters:
     - for: the ID of the album for which we want to fetch photos.
     - completion: code-block to execute after successfully completing the call.
     
     - Returns: An array of Photos objects. Array can be empty.
     */
    static func getPhotos(for albumId: Int, completion: @escaping PhotosResponse) {
        let target = Endpoint.allPhotos(albumId: albumId)
        API.fetch(provider: provider, endpoint: target, returnType: [Photo].self, completion: completion)
    }
    
    /**
     Fetches all Albums for a given userId.
     
     - Parameters:
     - for: the ID of the user for whom we want to fetch albums.
     - completion: code-block to execute after successfully completing the call.
     
     - Returns: An array of Album objects. Array can be empty.
     */
    static func getAlbums(for userId: Int, completion: @escaping AlbumsResponse) {
        let target = Endpoint.allAlbums(userId: userId)
        API.fetch(provider: provider, endpoint: target, returnType: [Album].self, completion: completion)
    }
    
    
    /**
     Fetches data from a given Target using a given Moya provider.
     
     - Parameters:
     - provider: A Moya provider.
     - endpoint: A `TargetType`-enum.
     - returnType: The type the responses should be in.
     - completion: What to do after the successful response triggers.
     */

    static func fetch<T: TargetType, P: MoyaProvider<T>, R: Decodable>(provider: P, endpoint: T, returnType: R.Type, completion: @escaping (R) -> ()) {
        
        provider.request(endpoint) { response in
            switch response {
            case let .success(result):
                do {
                    let results = try JSONDecoder().decode(returnType, from: result.data)
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
