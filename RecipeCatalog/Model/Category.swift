//
//  Category.swift
//  RecipeCatalog
//
//  Created by Дмитрий Федоринов on 29.10.2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import Foundation
import Firebase

/** Модель объекта категории, создается по прходяшему с FireBase json */
struct Category {
    
    let id: String
    let title: String
    let url: String?
    let ref: DatabaseReference?
    
    ///конструктор создает из скрина бд из фаербейса
    /// - parameter snapshot: снимок бд в json формате
    init(snapshot:DataSnapshot) {
        let json = snapshot.value as! [String:AnyObject]
        id = json["id"] as! String
        title = json["title"] as! String
        ref = snapshot.ref
        url = json["url"] as? String
    }
    
    ///конструктор создает из локальных данных
    init(id:String, title:String) {
        self.id = id
        self.title = title
        ref = nil
        url = nil
    }
}
