//
//  API.swift
//  memoirs
//
//  Created by Alejandro Ravasio on 18/03/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation
import Moya

/// Access point to JSONPlaceholder.
enum Endpoint: TargetType {
    
    case user(id: Int?)
    case allAlbums(userId: Int)
    case allPhotos(albumId: Int)
    
    /// The target's base `URL`.
    var baseURL: URL {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com") else { fatalError("baseURL could not be configured") }
        return url
    }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String {
        switch self {
        case .user(_):
            return "/users"
            
        case .allAlbums(_):
            return "/albums"
            
        case .allPhotos(_):
            return "/photos"
        }
    }
    
    /// The HTTP method used in the request.
    var method: Moya.Method {
        return .get
    }
    
    /// Provides stub data for use in testing.
    var sampleData: Data { return Data() }
    
    /// The type of HTTP task to be performed.
    var task: Task {
        switch self {
        case .user(let userId):
            guard let id = userId else {
                return .requestPlain
            }
            return .requestCompositeData(bodyData: Data(), urlParameters: ["id":id])        
            
        case .allAlbums(let userId):
            return .requestCompositeData(bodyData: Data(), urlParameters: ["userId":userId])
            
        case .allPhotos(let albumId):
            return .requestCompositeData(bodyData: Data(), urlParameters: ["albumId":albumId])
        }
    }
    
    /// The headers to be used in the request.
    var headers: [String : String]? { return nil }
    
}
