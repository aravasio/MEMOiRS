//
//  AlbumListVC.swift
//  memoirs
//
//  Created by Alejandro Ravasio on 20/03/2019.
//  Copyright © 2019 Alejandro Ravasio. All rights reserved.
//

import Foundation
import UIKit

class AlbumListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!

    private var messagesLabel: UILabel = UILabel()
    
    private var user: User!
    private var albums: [Album] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.show(message: "Loading Albums ...")
        API.getUser(id: 1, completion: { [weak self] user in
            if let u = user {
                self?.hideMessage()
                self?.onUserReceived(user: u)
            } else {
                self?.messagesLabel.text = "Couldn't fetch a user with the given id ... :("
            }
        })
    }
    
    
    func show(message: String) {
        messagesLabel.text = message
        messagesLabel.sizeToFit()
        messagesLabel.center = view.center
        view.addSubview(messagesLabel)
        tableView.isHidden = true
    }
    
    func hideMessage() {
        messagesLabel.removeFromSuperview()
        tableView.isHidden = false
    }
    func onUserReceived(user: User) {
        self.user = user
        API.getAlbums(for: user.id, completion: { [weak self] albums in
            self?.albums = albums
            self?.tableView.reloadData()
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let album = albums[indexPath.row]
        let vc = PhotosCollectionVC.create(for: album)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumCell", for: indexPath)
        
        let album = albums[indexPath.row]
        cell.textLabel?.text = album.title
        cell.detailTextLabel?.text = "Onwer: \(user.name)"
        return cell
    }
}
