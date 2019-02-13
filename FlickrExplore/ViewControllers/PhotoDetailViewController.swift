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
    var photoInfo:PhotoDetailCustom?
    
    
    //MARK:- properties
    var activityIndicatorView: UIActivityIndicatorView?
    
    
    //MARK:- View Lifecycle
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 350
        // Do any additional setup after loading the view.
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateUI(notification:)), name: Notification.Name(rawValue: "GetInfo"), object: nil)
        
        //Show Activity indicator
        showActivityIndicator()
    }
    
    
    
    
    //MARK:- Table View delegate methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell") as! ImageTableViewCell
            if let urlString = photoInfo?.rawFileURL{
                let url = URL(string: urlString)
                cell.photoView.sd_setImage(with: url, completed: nil)
            }
            
            return cell
            
        }else if (indexPath.row == 1){
            let cell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell") as! ImageDescriptionTableViewCell
            cell.ownerNameLabel.text = photoInfo?.ownerUsername
            cell.locationLabel.text = photoInfo?.ownerLocation
            cell.descriptionTextView.text =  photoInfo?.descriptionText
            
            //Load first five tags
            if let tags = photoInfo?.tags{
                for (index,tagName) in tags.enumerated(){
                    if index < 5{
                        cell.tagButtons[index].setTitle(tagName, for: .normal)
                    }
                }
            }
            
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "shareCell") as! UITableViewCell
            return cell
        }
    }
   
    
    //MARK:- IBActions
    
    //Function to search for new tag and navigating back
    @IBAction func tagButtonPressed(_ sender: UIButton) {
        
        if let navigationController = self.parent as? UINavigationController{
            if let parentVC = navigationController.viewControllers[navigationController.viewControllers.count - 2] as? GalleryViewController{
                parentVC.searchTag = sender.titleLabel?.text
                parentVC.isFilteredSearchOn = false
                
                self.navigationController?.popViewController(animated: true)
            }
        }
        
    }

    //Function to load image and use iOS Native sharing feature
    @IBAction func shareButtonPressed(_ sender: Any) {
        let photoURL = URL(string: (photoInfo?.rawFileURL)!)
        let image = try! UIImage.sd_image(with: Data(contentsOf: photoURL!))
        
        let imageToShare = [ image! ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    //MARK:- Functionalities
    
    //Function to initialize and loading activity indicator.
    func showActivityIndicator() {
        activityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: (self.view.frame.width)/2 - 50, y: 100, width: 100, height: 100))
        self.view.addSubview(activityIndicatorView!)
        activityIndicatorView?.startAnimating()
    }
    
    //Function to stop current running animation and reloading table view with new data recieved inside the notification. Called by Notification system on recieving network callback.
    @objc func updateUI(notification: NSNotification) {
        activityIndicatorView?.stopAnimating()
        if let data = notification.object as? PhotoDetailCustom{
            photoInfo = data
            tableView.reloadData()
        }
    }
}
