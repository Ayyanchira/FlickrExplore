//
//  GalleryViewModel.swift
//  FlickrExplore
//
//  Created by Akshay Ayyanchira on 2/2/19.
//  Copyright © 2019 Akshay Ayyanchira. All rights reserved.
//

import UIKit

class GalleryViewModel: NSObject {
    
    var searchTag:String?
    public static var photos: Photos?{
        didSet{
            
        }
    }
    
    func numberOfRowInSection(tableView: UITableView, section: Int) -> Int {
        return GalleryViewModel.photos?.photos.photo.count ?? 1
    }
    
    func cellForRowAtIndexPath(tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = GalleryViewModel.photos?.photos.photo[indexPath.row].title
        return cell
    }
    
    
    public init(searchTag: String){
        self.searchTag = searchTag
    }
}
