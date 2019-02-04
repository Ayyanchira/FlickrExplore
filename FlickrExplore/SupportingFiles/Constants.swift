//
//  Constants.swift
//  FlickrExplore
//
//  Created by Akshay Ayyanchira on 2/3/19.
//  Copyright © 2019 Akshay Ayyanchira. All rights reserved.
//

import Foundation

struct Constants {
    struct FlickrAPI {
        static let APIScheme = "https"
        static let APIHost = "api.flickr.com"
        static let APIPath = "services/rest"
    }
    
    struct APIKeys {
        static let SearchMethod = "method"
        static let APIKey = "api_key"
        static let Extras = "extras"
        static let ResponseFormat = "format"
        static let DisableJSONCallback = "nojsoncallback"
        static let SafeSearch = "safe_search"
        static let Text = "text"
    }
    
    struct API_Search_Method_Values {
        static let SearchMethod = "flickr.photos.search"
        static let APIKey = "6a8e0794c29c9c6641e639af0f2e0754"
//        static let Extras = "extras"
        static let ResponseFormat = "json"
        static let DisableJSONCallback = "1"
        static let SafeSearch = "1"
        static let MediumURL = "url_m"
//        static let Text = "text"
    }
    
    struct API_Get_Info_Values {
        static let GetInfoMethod = "flickr.photos.getInfo"
        static let APIKey = "6a8e0794c29c9c6641e639af0f2e0754"
        static let ResponseFormat = "json"
        static let DisableJSONCallback = "1"
    }
}
