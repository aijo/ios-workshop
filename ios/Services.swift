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
    
    class var sharedInstance: Services {
        struct Static {
            static let instance: Services = Services()
        }
        return Static.instance
    }
    
    typealias mediaCompletion = (_ medias: Medias?, _ error: Error?) -> Void
    
    func getInstagramFeed(user: String, maxId:String?=nil, completion: @escaping mediaCompletion) {
        var mediaEndpoint = "https://www.instagram.com/\(user)/media/"
        if let maxId = maxId {
            mediaEndpoint += "?max_id=\(maxId)"
        }
        print(mediaEndpoint)
        
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
    
    typealias downloadProgress = (_ progress: Double) -> Void
    typealias uiImageCompletion = (_ image: UIImage?, _ error: Error?) -> Void
    
    func getImage(imageUrl: String, downloadProgress: downloadProgress?=nil, completion: @escaping uiImageCompletion) {
        Alamofire.request(imageUrl)
            .downloadProgress { progress in
                downloadProgress?(progress.fractionCompleted)
            }
            .responseData { response in
                switch response.result {
                case .success(let data):
                    completion(UIImage(data: data), nil)
                case .failure(let error):
                    print("Request failed with error: \(error)")
                    completion(nil, error)
                }
        }
    }
    
}
