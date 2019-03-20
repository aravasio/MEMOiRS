//
//  PotosCollectionVC.swift
//  memoirs
//
//  Created by Alejandro Ravasio on 20/03/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation
import UIKit
import Nuke


class PhotosCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    static let identifier = "PhotosCollectionVC"
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var album: Album!
    var photos: [Photo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return photos.count
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotosCell", for: indexPath) as! PhotosCell
        //https://cloud.githubusercontent.com/assets/1567433/13918338/f8670eea-ef7f-11e5-814d-f15bdfd6b2c0.png
        return cell
    }
    
    
    class func create(for album: Album) -> PhotosCollectionVC {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: PhotosCollectionVC.identifier) as! PhotosCollectionVC
        vc.album = album
        return vc
    }
}
