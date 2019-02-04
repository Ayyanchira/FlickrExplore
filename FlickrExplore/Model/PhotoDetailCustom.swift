//
//  PhotoDetailCustom.swift
//  FlickrExplore
//
//  Created by Akshay Ayyanchira on 2/3/19.
//  Copyright © 2019 Akshay Ayyanchira. All rights reserved.
//

import Foundation

class PhotoDetailCustom {
    var photoID, secret, server:String
    var tags:[String]?
    var descriptionText: String?
    var ownerUsername: String
    var ownerLocation: String?
    var rawFileURL: String
    
    init(photoID: String, secret:String, server:String, tags:[String]?, descriptionText: String, owner:String, location: String?, fileURL: String) {
        self.secret = secret
        self.server = server
        self.photoID = photoID
        self.tags = tags
        self.descriptionText = descriptionText
        self.ownerUsername = owner
        self.ownerLocation = location
        self.rawFileURL = fileURL
    }
    
    init() {
        self.secret = ""
        self.server = ""
        self.photoID = ""
        self.tags = []
        self.descriptionText = ""
        self.ownerUsername = ""
        self.ownerLocation = ""
        self.rawFileURL = ""
    }
}
