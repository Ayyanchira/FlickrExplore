//
//  HomeViewController.swift
//  FlickrExplore
//
//  Created by Akshay Ayyanchira on 2/2/19.
//  Copyright © 2019 Akshay Ayyanchira. All rights reserved.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var searchBoxTextField: UITextField!
    var cats:[CatModel] = [CatModel]()
    var audioPlayer : AVAudioPlayer?
    var isEven = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSetup()
        loadCatModel()
        
    }
    
    // Initial setup
    func viewSetup() {
        self.navigationItem.title = "FlickrSearch!"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.07579580694, green: 0.08882082254, blue: 0.1714539528, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9886394143, green: 1, blue: 0.9957388043, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        searchBoxTextField.delegate = self
    }
    
    func loadCatModel()  {
        //Make sure you have this file. There is no if let check in initializer or anywhere. The app may crash otherwise
        let catNames = ["BigCat","SmallCat"]
        let catAudioNames = ["Cat-meow-short","Cat-meow-audio-clip"]
        let catImages = [#imageLiteral(resourceName: "UIHere"),#imageLiteral(resourceName: "UIHere-2")]
        
        
        for (index,catName) in catNames.enumerated(){
            let catObject = CatModel(soundName: catAudioNames[index], name: catName, image: catImages[index])
            cats.append(catObject)
        }
    }
    
    
    //MARK:- IBActions
    @IBAction func swipeGestureTriggered(_ sender: UISwipeGestureRecognizer) {
        if (sender.direction == .down){
            searchBoxTextField.resignFirstResponder()
        }
    }
    
    @IBAction func kittenButtonPressed(_ sender: UIButton){
        
        //Choose a cat by random
        let cat = cats[Int.random(in: 0..<cats.count)]
        
        //Play sound made by that cat
        audioPlayer = AVAudioPlayer()
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: cat.soundURL)
            audioPlayer?.play()
        } catch  {
            print("Error occured in playing the sound...")
        }
        
        //load image
        let imageView = UIImageView(frame: CGRect(x: 40, y: self.view.frame.height, width: 200, height: 500))
        imageView.image = cat.image
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
        
        
        //animate image
        UIView.animate(withDuration: 1.0, animations: {
            let screenWidth = self.view.frame.width
            let randomX1 = Float.random(in: Float(screenWidth/2) ..< Float(screenWidth - 200))
            let randomX2 = Float.random(in: -100 ..< Float(screenWidth/4))
            
            //Flipping sides to control randomness to some extent
            let randomX = self.isEven ? randomX1 : randomX2
            self.isEven = !self.isEven
            
            imageView.frame =  CGRect(x: CGFloat(randomX), y: imageView.frame.origin.y - 350, width: 200, height: 350)
        }) { (isAnimationComplete) in
            imageView.removeFromSuperview()
        }
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        if searchBoxTextField.text != ""{
            let tagText = searchBoxTextField.text!
            let replaced = String(tagText.map{
                $0 == " " ? "_" : $0
            })
            self.performSegue(withIdentifier: "showSearchResults", sender: replaced)
        }
    }
    
    
    //MARK:- UI Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSearchResults"{
            let galleryVC = segue.destination as! GalleryViewController
            galleryVC.searchTag = sender as? String
        }
    }
    
    //MARK:- Delegate Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchBoxTextField.resignFirstResponder()
        searchButtonPressed(searchBoxTextField)
        return true
    }

}

