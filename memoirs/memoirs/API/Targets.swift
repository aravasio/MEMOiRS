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
enum JSONPlaceholderTarget: TargetType {
    
    case user(id: Int?)
    case album(userId: Int)
    case photo(albumId: Int)
    
    var baseURL: URL {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com") else { fatalError("baseURL could not be configured") }
        return url
    }
    
    var path: String {
        switch self {
        case .user(_):
            return "/users"
            
        case .album(_):
            return "/albums"
            
        case .photo(_):
            return "/photos"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case .user(let userId):
            guard let id = userId else {
                return .requestPlain
            }
    
            return .requestCompositeData(bodyData: Data(), urlParameters: ["id":id])        
            
        case .album(let userId):
            return .requestCompositeData(bodyData: Data(), urlParameters: ["userId":userId])
        case .photo(let albumId):
            return .requestCompositeData(bodyData: Data(), urlParameters: ["albumId":albumId])
        }
    }
    
    /// JSONPlaceholder uses query strings, so headers will just be nil.
    var headers: [String : String]? { return nil }
    
    /// sampleData is the way Moya helps streamlines mocking of data. For now we'll just return Data(). If time allows for it, we can eventually implement this.
    var sampleData: Data { return Data() }
    
}
