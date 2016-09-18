//
//  Services.swift
//  ios
//
//  Created by Chanintorn Asavavichairoj on 9/18/2559 BE.
//  Copyright © 2559 JO. All rights reserved.
//

import Alamofire
import ObjectMapper

class Services {
    
    typealias mediaCompletion = (_ medias: Medias?, _ error: Error?) -> Void
    
    func getInstagramFeed(user: String, completion: @escaping mediaCompletion) {
        let mediaEndpoint = "https://www.instagram.com/\(user)/media/"
        
        Alamofire.request(mediaEndpoint, method: .get, parameters: nil).responseJSON { (response) in
            switch response.result {
            case .success(let data):
                let medias = Medias(JSON: data as! [String: Any])
                completion(medias, nil)
            case .failure(let error):
                print("Request failed with error: \(error)")
                completion(nil, error)
            }
        }
    }
    
}
