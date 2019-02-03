//
//  GalleryViewController.swift
//  FlickrExplore
//
//  Created by Akshay Ayyanchira on 2/2/19.
//  Copyright © 2019 Akshay Ayyanchira. All rights reserved.
//

import UIKit
import SDWebImage

class GalleryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    //MARK:- Properties
    var searchTag:String?
    static var photos: Photos?
    
    //MARK:- Injection
    //lazy var galleryViewModel:GalleryViewModel = GalleryViewModel(searchTag: self.searchTag!)
    
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTableView), name: Notification.Name("reloadGallery"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setTitle()
        NetworkService.getPhotoListFor(tag: searchTag!)
    }
    
    func setTitle() {
        self.navigationItem.title = "# \(searchTag ?? "Recent") "
    }


    //MARK:- Table view delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.galleryViewModel.numberOfRowInSection(tableView: tableView, section: section)
        guard GalleryViewController.photos != nil else {
            return 0
        }
        return GalleryViewController.photos?.photos.photo.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //return galleryViewModel.cellForRowAtIndexPath(tableView: tableView, indexPath: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "gallaryCell") as! GalleryTableViewCell
        cell.imageTitle.text = GalleryViewController.photos?.photos.photo[indexPath.row].title
        let imageURL = URL(string: "https://farm\(GalleryViewController.photos!.photos.photo[indexPath.row].farm).staticflickr.com/\(GalleryViewController.photos!.photos.photo[indexPath.row].server)/\(GalleryViewController.photos!.photos.photo[indexPath.row].id)_\(GalleryViewController.photos!.photos.photo[indexPath.row].secret).jpg")
        
        cell.thumbnailImageView.sd_setImage(with: imageURL, completed: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: GalleryViewController.photos!.photos.photo[indexPath.row])
    }
    
    @objc func refreshTableView() {
        tableView.reloadData()
    }
    
}
