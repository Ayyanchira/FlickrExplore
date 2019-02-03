//
//  NetworkService.swift
//  FlickrExplore
//
//  Created by Akshay Ayyanchira on 2/2/19.
//  Copyright © 2019 Akshay Ayyanchira. All rights reserved.
//

import UIKit
import Alamofire

class NetworkService: NSObject {

    static public func getPhotoListFor(tag tagName:String)  {
        
        Alamofire.request("https://api.flickr.com/services/rest/?method=\(Constants.API_Search_Method_Values.SearchMethod)&api_key=\(Constants.API_Search_Method_Values.APIKey)&format=json&nojsoncallback=1&text=\(tagName)", method: .get, parameters: nil, encoding: JSONEncoding.prettyPrinted, headers: nil).responsePhotos { (response) in
            if let json = response.result.value{
                print("Its inside finally and the count is \(json.photos.photo.count)")
                DispatchQueue.main.async {
                    GalleryViewController.photos = json
                    NotificationCenter.default.post(name: .init("reloadGallery"), object: nil)
                }
            }else{
                print("Still no hope. Error \(response.error?.localizedDescription)")
            }
        }
    }
    
}
