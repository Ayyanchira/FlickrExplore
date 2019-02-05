//
//  HomeViewController.swift
//  FlickrExplore
//
//  Created by Akshay Ayyanchira on 2/2/19.
//  Copyright © 2019 Akshay Ayyanchira. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var searchBoxTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "FlickrSearch!"
        
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.07579580694, green: 0.08882082254, blue: 0.1714539528, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9886394143, green: 1, blue: 0.9957388043, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        
    }
    
    @IBAction func searchButtonPressed(_ sender: Any) {
        self.performSegue(withIdentifier: "showSearchResults", sender: searchBoxTextField.text)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSearchResults"{
            let galleryVC = segue.destination as! GalleryViewController
            galleryVC.searchTag = searchBoxTextField.text
        }
        
    }

}
