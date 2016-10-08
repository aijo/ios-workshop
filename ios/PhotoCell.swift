//
//  PhotoCell.swift
//  ios
//
//  Created by Jo on 10/8/16.
//  Copyright © 2016 JO. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    private let service = Services.sharedInstance
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupCell(item: Item) {
        if let avatar = item.imageUrl {
            service.getImage(imageUrl: avatar,
            downloadProgress: { (progress) in
                //print(progress)
            }) { (image, error) in
                self.photoImageView.image = image
            }
        }
    }
    
}
