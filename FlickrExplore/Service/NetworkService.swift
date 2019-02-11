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
        
        Alamofire.request("https://api.flickr.com/services/rest/?method=\(Constants.API_Search_Method_Values.SearchMethod)&api_key=\(Constants.API_Search_Method_Values.APIKey)&format=json&nojsoncallback=1&tags=\(tagName)&extras=description,tags", method: .get, parameters: nil, encoding: JSONEncoding.prettyPrinted, headers: nil).responsePhotos { (response) in
            if let json = response.result.value{
                print("Its inside finally and the count is \(json.photos.photo.count)")
                DispatchQueue.main.async {
                    GalleryViewController.photos = json
                    NotificationCenter.default.post(name: .init("reloadGallery"), object: nil)
                }
            }else{
                print("Model class mapping failed. Error \(response.error?.localizedDescription ?? "not found")")
            }
        }
    }
    
    //To get details of specific photo
    static public func getPhotoInfo(photoID: String)  {
        
        Alamofire.request("https://api.flickr.com/services/rest/?method=flickr.photos.getInfo&api_key=6a8e0794c29c9c6641e639af0f2e0754&format=json&photo_id=\(photoID)&nojsoncallback=1", method: .get, parameters: nil, encoding: JSONEncoding.prettyPrinted, headers: nil).responseJSON { (response) in
            if let json = response.result.value{
                var secret = "", server = "", descriptionText = "", owner = "", location = "", rawFileUrl = ""
                var tagCollection:[String] = []
                
                if let jsonObject = json as? [String : Any]{
                    guard let photo = jsonObject["photo"] as? [String: Any] else{
                        print("Parsing problem...")
                        return
                    }
                    
                    guard let secret = photo["secret"] as? String else{
                        return
                    }
                    
                    guard let server = photo["server"] as? String else{
                        return
                    }
                    
                    guard let farm = photo["farm"] as? Int else{
                        return
                    }
                    
                    //Extracting description
                    guard let descriptionObject = photo["description"] as? [String: Any] else{
                        print("Description element not found")
                        return
                    }
                    
                    if let description = descriptionObject["_content"] as? String {
                        descriptionText = description
                    }
                    
                    //Extraction owner name and location
                    guard let ownerObject = photo["owner"] as? [String: Any] else{
                        return
                    }
                    
                    guard let ownerUsername = ownerObject["username"] as? String else{
                        return
                    }
                    
                    guard let userLocation = ownerObject["location"] as? String else{
                        return
                    }
                    
                    //Extracting tags
                    if let tagsObject = photo["tags"] as? [String: Any],
                    let tagArray = tagsObject["tag"] as? [[String: Any]]{
                        print("There are \(tagArray.count) tags")
                        for tag in tagArray{
                            if let tag = tag["_content"] as? String{
                                tagCollection.append(tag)
                            }
                        }
                    }
                    
                    //Build URL for image
                    rawFileUrl = "https://farm\(farm).staticflickr.com/\(server)/\(photoID)_\(secret).jpg"
                    
                    let photoDetail = PhotoDetailCustom(photoID: photoID, secret: secret, server: server, tags: tagCollection, descriptionText: descriptionText, owner: ownerUsername, location: location, fileURL: rawFileUrl)
                    
                    NotificationCenter.default.post(name: .init("GetInfo"), object: photoDetail)
                    
                }
            }else{
                print("Error while requesting the service")
            }
        }
        
    }
    
    
    
}
