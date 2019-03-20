//
//  PotosCollectionVC.swift
//  memoirs
//
//  Created by Alejandro Ravasio on 20/03/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation
import UIKit

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
        print("did select photo")
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
