//
//  ImageDescriptionTableViewCell.swift
//  FlickrExplore
//
//  Created by Akshay Ayyanchira on 2/3/19.
//  Copyright © 2019 Akshay Ayyanchira. All rights reserved.
//

import UIKit

class ImageDescriptionTableViewCell: UITableViewCell {

    
    //MARK:- IBOUTlets
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    //MARK:- properties
    @IBOutlet var tagButtons: [UIButton]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
