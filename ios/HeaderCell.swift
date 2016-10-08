//
//  HeaderCell.swift
//  ios
//
//  Created by Jo on 10/8/16.
//  Copyright © 2016 JO. All rights reserved.
//

import UIKit

class HeaderCell: UICollectionViewCell {
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    
    private let USER_IMAGE_SIZE:CGFloat = 50
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImageView.layer.cornerRadius = USER_IMAGE_SIZE/2
        userImageView.layer.masksToBounds = true
    }
    
    @IBAction func leftMenuDidPressed(_ sender: AnyObject) {
    }
    
    @IBAction func centeMenuDidPressed(_ sender: AnyObject) {
    }
    
    @IBAction func rightMenuDidPressed(_ sender: AnyObject) {
    }
    
}
