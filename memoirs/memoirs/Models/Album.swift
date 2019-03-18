//
//  Album.swift
//  memoirs
//
//  Created by Alejandro Ravasio on 18/03/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation

/**
 Model representation of a Photo Album.
 
 - parameters:
     - id: The album's ID
     - userId: The album's owner ID
     - title: The album's name.
 */

struct Album: Codable {
    
    let id: Int
    let userId: Int
    let title: String
}
