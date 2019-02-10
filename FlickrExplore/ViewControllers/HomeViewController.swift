//
//  HomeViewController.swift
//  FlickrExplore
//
//  Created by Akshay Ayyanchira on 2/2/19.
//  Copyright © 2019 Akshay Ayyanchira. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var searchBoxTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewSetup()
    }
    
    // Initial setup
    func viewSetup() {
        self.navigationItem.title = "FlickrSearch!"
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.07579580694, green: 0.08882082254, blue: 0.1714539528, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.9886394143, green: 1, blue: 0.9957388043, alpha: 1)
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        searchBoxTextField.delegate = self
    }
    
    
    //MARK:- IBActions
    @IBAction func swipeGestureTriggered(_ sender: UISwipeGestureRecognizer) {
        if (sender.direction == .down){
            searchBoxTextField.resignFirstResponder()
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
