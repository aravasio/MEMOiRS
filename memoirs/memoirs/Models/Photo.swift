//
//  Photo.swift
//  memoirs
//
//  Created by Alejandro Ravasio on 18/03/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation

/**
 Model representation of a Photo.
 */

struct Photo: Codable {
    let id: Int
    let albumId: Int
    let title: String
    let url: URL
    let thumbnailUrl: URL
}
