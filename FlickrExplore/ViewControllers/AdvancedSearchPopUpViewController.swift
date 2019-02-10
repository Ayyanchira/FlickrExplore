//
//  AdvancedSearchPopUpViewController.swift
//  FlickrExplore
//
//  Created by Akshay Ayyanchira on 2/9/19.
//  Copyright © 2019 Akshay Ayyanchira. All rights reserved.
//

import UIKit


protocol ListenToSearchDelegate {
    func performSearchUsing(keywords:String)
}

class AdvancedSearchPopUpViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    var delegate: ListenToSearchDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func filterButtonPressed(_ sender: UIButton) {
        if delegate != nil && searchTextField.text != ""{
            delegate?.performSearchUsing(keywords: searchTextField.text!)
            self.dismiss(animated: true, completion: nil)
        }else{
            print("Delegate is not set. Which means parent view is not interested to listen to this protocol. Have the parent view set this delegate to itsself and implement this method")
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
