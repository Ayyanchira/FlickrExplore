//
//  GalleryViewController.swift
//  FlickrExplore
//
//  Created by Akshay Ayyanchira on 2/2/19.
//  Copyright © 2019 Akshay Ayyanchira. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {

    var searchTag:String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setTitle()
        
    }
    
    func setTitle() {
        self.navigationItem.title = "# \(searchTag ?? "Recent") "
    }


}
