//
//  Item.swift
//  ios
//
//  Created by Chanintorn Asavavichairoj on 9/18/2559 BE.
//  Copyright © 2559 JO. All rights reserved.
//

import ObjectMapper

struct Item: Mappable {
    var location: String?
    var imageUrl: String?
    var username: String?
    var avatar:   String?
    var likes:    Int?
    var caption:  String?
    var datetime: Date?
    var id:       String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        location    <- map["location.name"]
        imageUrl    <- map["images.standard_resolution.url"]
        caption     <- map["caption.text"]
        username    <- map["caption.from.username"]
        avatar      <- map["caption.from.profile_picture"]
        likes       <- map["likes.count"]
        datetime    <- (map["caption.created_time"], DateTransform())
        id          <- map["caption.id"]
    }
}
