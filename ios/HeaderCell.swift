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
    
    private let service = Services.sharedInstance
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        userImageView.layer.cornerRadius = USER_IMAGE_SIZE/2
        userImageView.layer.masksToBounds = true
    }
    
    func setupCell(viewModel: ViewModel?) {
        usernameLabel.text = viewModel?.username
        
        if let avatar = viewModel?.avatar {
            service.getImage(imageUrl: avatar, completion: { (image, error) in
                self.userImageView.image = image
            })
        }
    }
    
    @IBAction func leftMenuDidPressed(_ sender: AnyObject) {
    }
    
    @IBAction func centeMenuDidPressed(_ sender: AnyObject) {
    }
    
    @IBAction func rightMenuDidPressed(_ sender: AnyObject) {
    }
    
}
