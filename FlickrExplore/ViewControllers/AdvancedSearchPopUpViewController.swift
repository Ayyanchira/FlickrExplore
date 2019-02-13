//
//  AdvancedSearchPopUpViewController.swift
//  FlickrExplore
//
//  Created by Akshay Ayyanchira on 2/9/19.
//  Copyright © 2019 Akshay Ayyanchira. All rights reserved.
//

import UIKit


protocol ListenToSearchDelegate {
    func performSearchUsing(keywords:String, isFilterOn:Bool)
}

class AdvancedSearchPopUpViewController: UIViewController, UITextFieldDelegate {

    //MARK:- IBOutlets
    @IBOutlet weak var filterSwitch: UISwitch!
    @IBOutlet weak var searchTextField: UITextField!
    
    //MARK:- Properties
    var delegate: ListenToSearchDelegate?
    var isFilterOn:Bool?
    
    //MARK:- View Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
         initializeFilterSwitchState()
    }
    
    //MARK:- IBActions
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func filterValueChanged(_ sender: UISwitch) {
        updateGallery()
    }
    

    //MARK:- Helper functions
    
    func initializeFilterSwitchState() {
        if let filterOn = isFilterOn {
            filterSwitch.setOn(filterOn ? true : false, animated: false)
        }else{
            filterSwitch.setOn(false, animated: false)
        }
    }
    
    //Callback function to update gallery on parent view controller invoked when text is beeen edited on textfield.
    @objc func textFieldDidChange(_textField:UITextField){
        if filterSwitch.isOn{
            updateGallery()
        }
    }
    
    fileprivate func updateGallery() {
        if delegate != nil{
            delegate?.performSearchUsing(keywords: searchTextField.text!, isFilterOn: self.filterSwitch.isOn)
        }else{
            print("Delegate is not set. Which means parent view is not interested to listen to this protocol. Have the parent view set this delegate to itsself and implement this method")
        }
    }
}
