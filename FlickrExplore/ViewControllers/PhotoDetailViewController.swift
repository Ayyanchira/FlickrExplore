//
//  PhotoDetailViewController.swift
//  FlickrExplore
//
//  Created by Akshay Ayyanchira on 2/3/19.
//  Copyright © 2019 Akshay Ayyanchira. All rights reserved.
//

import UIKit

class PhotoDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK:- IBOUTlets
    
    
    //MARK:- properties
    
    
    
    //MARK:- View Lifecycle
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 350
        // Do any additional setup after loading the view.
    }
    
    
    
    
    //MARK:- Table View delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as! ImageTableViewCell
            return cell
            
        }else if (indexPath.row == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell") as! ImageDescriptionTableViewCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "shareCell") as! UITableViewCell
            
            return cell
        }
    }
   
    
    //MARK:- IBActions
    @IBAction func tagButtonPressed(_ sender: UIButton) {
        
        if let navigationController = self.parent as? UINavigationController{
            if let parentVC = navigationController.viewControllers[navigationController.viewControllers.count - 2] as? GalleryViewController{
                parentVC.searchTag = sender.titleLabel?.text
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }

}
