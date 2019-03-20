//
//  PhotosCell.swift
//  memoirs
//
//  Created by Alejandro Ravasio on 20/03/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class PhotosCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    private var photo: Photo!
    
    func configure(with photo: Photo) {
        self.photo = photo
        
        self.imageView.kf.indicatorType = .activity
        self.imageView.kf.setImage(
            with: photo.thumbnailUrl,
            placeholder: nil,
            options: [
                .processor(RoundCornerImageProcessor(cornerRadius: 20))
            ])
    }
}
