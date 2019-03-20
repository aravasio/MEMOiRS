//
//  PotosCollectionVC.swift
//  memoirs
//
//  Created by Alejandro Ravasio on 20/03/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation
import UIKit
import Lightbox

class PhotosCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    static let identifier = "PhotosCollectionVC"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var album: Album!
    var photos: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        API.getPhotos(for: album.id, completion: { [weak self] photos in
            self?.photos = photos
            self?.collectionView.reloadData()
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photo = photos[indexPath.row]
        
        // Create an instance of LightboxController.
        let controller = LightboxController(images: [LightboxImage(imageURL: photo.url, text: photo.title, videoURL: nil)])
        controller.dynamicBackground = true
        
        present(controller, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath) as! PhotosCell
        let photo = photos[indexPath.row]
        cell.configure(with: photo)
        return cell
    }
    
    
    class func create(for album: Album) -> PhotosCollectionVC {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: PhotosCollectionVC.identifier) as! PhotosCollectionVC
        vc.album = album
        return vc
    }
}
