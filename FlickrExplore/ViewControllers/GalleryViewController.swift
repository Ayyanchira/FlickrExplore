//
//  GalleryViewController.swift
//  FlickrExplore
//
//  Created by Akshay Ayyanchira on 2/2/19.
//  Copyright © 2019 Akshay Ayyanchira. All rights reserved.
//

import UIKit
import SDWebImage

class GalleryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIPopoverPresentationControllerDelegate, ListenToSearchDelegate {
    
    
    
    //Mar:- IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK:- Properties
    var searchTag:String?{
        didSet{
            NetworkService.getPhotoListFor(tag: searchTag!)
        }
    }
    
    var isFilteredSearchOn = false
    var filteredPhotos:[Photo] = [Photo]()
    static var photos: Photos?
    
    //MARK:- Injection
    //lazy var galleryViewModel:GalleryViewModel = GalleryViewModel(searchTag: self.searchTag!)
    
    
    //MARK:- View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Listen to observer
        NotificationCenter.default.addObserver(self, selector: #selector(refreshTableView), name: Notification.Name("reloadGallery"), object: nil)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setTitle()
        //NetworkService.getPhotoListFor(tag: searchTag!)
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
        if isFilteredSearchOn{
            return filteredPhotos.count
        }
        return GalleryViewController.photos?.photos.photo.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //return galleryViewModel.cellForRowAtIndexPath(tableView: tableView, indexPath: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "gallaryCell") as! GalleryTableViewCell
        cell.imageTitle.text = ""
        
        
        var imageURL:URL
        if (isFilteredSearchOn){
            imageURL = URL(string: "https://farm\(filteredPhotos[indexPath.row].farm).staticflickr.com/\(filteredPhotos[indexPath.row].server)/\(filteredPhotos[indexPath.row].id)_\(filteredPhotos[indexPath.row].secret).jpg")!
        }else{
            imageURL = URL(string: "https://farm\(GalleryViewController.photos!.photos.photo[indexPath.row].farm).staticflickr.com/\(GalleryViewController.photos!.photos.photo[indexPath.row].server)/\(GalleryViewController.photos!.photos.photo[indexPath.row].id)_\(GalleryViewController.photos!.photos.photo[indexPath.row].secret).jpg")!
        }
        
        cell.selectionStyle = .none
        cell.thumbnailImageView.sd_setImage(with: imageURL, completed: nil)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedPhoto = isFilteredSearchOn ? filteredPhotos[indexPath.row] : GalleryViewController.photos!.photos.photo[indexPath.row] 
        performSegue(withIdentifier: "showDetail", sender: selectedPhoto)
        NetworkService.getPhotoInfo(photoID: selectedPhoto.id)
    }
    
    @objc func refreshTableView() {
        tableView.reloadData()
    }
    
    @IBAction func advancedSearchPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "advancedSearch", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "advancedSearch"{
            let advancedSearchPopOverVC = segue.destination as! AdvancedSearchPopUpViewController
            advancedSearchPopOverVC.modalPresentationStyle = .popover
            advancedSearchPopOverVC.view.frame = CGRect(x: advancedSearchPopOverVC.view.frame.origin.x, y: advancedSearchPopOverVC.view.frame.origin.y, width: self.view.frame.width, height: advancedSearchPopOverVC.view.frame.height)
            advancedSearchPopOverVC.popoverPresentationController?.delegate = self
            advancedSearchPopOverVC.isFilterOn = isFilteredSearchOn
            advancedSearchPopOverVC.delegate = self
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    
    func performSearchUsing(keywords: String, isFilterOn: Bool) {
        
        if keywords == ""{
            isFilteredSearchOn = false
            tableView.reloadData()
            return
        }
        
        isFilteredSearchOn = isFilterOn
        filteredPhotos.removeAll()
        
        for (_,photo) in (GalleryViewController.photos?.photos.photo.enumerated())!{
            
            //Check title
            if photo.title.lowercased().contains(keywords.lowercased()){
                print("Photo title is \(photo.title)")
                filteredPhotos.append(photo)
                continue
            }
            
            //Check description
            if photo.description.content.lowercased().contains(keywords.lowercased()){
                filteredPhotos.append(photo)
                continue
            }
            
            //Check tags
            if photo.tags.lowercased().contains(keywords.lowercased()){
                filteredPhotos.append(photo)
                continue
            }
        }
        
        print("Total filtered array only contains \(filteredPhotos.count) elements")
        tableView.reloadData()
    }
    
}
