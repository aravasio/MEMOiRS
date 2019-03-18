//
//  User.swift
//  memoirs
//
//  Created by Alejandro Ravasio on 18/03/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation

/**
 Model representation of a User.
 */

struct User: Codable {
    //Address struct definition
    struct Address: Codable {
        struct Location: Codable {
            let lat: String
            let lng: String
        }
        
        let street: String
        let suite: String
        let city: String
        let zipcode: String
        let geo: Location
    }
    
    //Company struct definition
    struct Company: Codable {
        let name: String
        let catchPhrase: String
        let bs: String
    }
    
    //Properties
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: Address
    let phone: String
    let website: String
    let company: Company
}
