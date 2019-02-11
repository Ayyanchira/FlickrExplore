//
//  CatModel.swift
//  CatAnimation
//
//  Created by Akshay Ayyanchira on 2/9/19.
//  Copyright © 2019 Akshay Ayyanchira. All rights reserved.
//

import Foundation
import UIKit

class CatModel: NSObject {
    let soundURL: URL
    let name: String
    let image: UIImage
    
    init(soundName:String, name:String, image:UIImage) {
//        let soundURL = URL(string: soundLocation)
        let soundURL = Bundle.main.url(forResource: soundName, withExtension: "mp3")!
        self.name = name
        self.soundURL = soundURL
        self.image = image
    }
}
