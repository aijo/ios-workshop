//
//  ViewModel.swift
//  ios
//
//  Created by Jo on 10/8/16.
//  Copyright © 2016 JO. All rights reserved.
//

import Foundation
import RxSwift

class ViewModel {
    
    var username: String
    var lastMaxId: String?
    
    let service = Services.sharedInstance
    var observable: BehaviorSubject<[Item]>
    let disposeBag = DisposeBag()
    
    init(username: String) {
        self.username = username
        self.observable = BehaviorSubject(value:[Item]())
        
        loadData()
        
        UserDefaults.standard.set(username, forKey: APP_USERNAME)
    }
    
    func loadData() {
        service.getInstagramFeed(user: username, maxId: lastMaxId) { (medias, error) in
            if let items = medias?.items {
                self.lastMaxId = items.last?.id
                self.observable.on(.next(items))
            }
        }
    }
    
    typealias itemSubscribe = (_ items: [Item]?) -> Void
    
    func subscribe(on: @escaping itemSubscribe) {
        let disposable = observable.subscribe { (event) in
            on(event.element)
        }
        disposable.addDisposableTo(disposeBag)
    }
    
}
