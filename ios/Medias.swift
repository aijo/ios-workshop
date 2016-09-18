//
//  Medias.swift
//  ios
//
//  Created by Chanintorn Asavavichairoj on 9/18/2559 BE.
//  Copyright © 2559 JO. All rights reserved.
//

import ObjectMapper

struct Medias: Mappable {
    var status: String?
    var items: [Item]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        items  <- map["items"]
    }
}
