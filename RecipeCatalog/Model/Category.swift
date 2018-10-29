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
    
    let id: Int
    let title: String
    let ref: DatabaseReference
    
    /// - parameter snapshot: снимок бд в json формате
    init(snapshot:DataSnapshot) {
        let json = snapshot.value as! [String:AnyObject]
        id = json["id"] as! Int
        title = json["title"] as! String
        ref = snapshot.ref
    }
}
