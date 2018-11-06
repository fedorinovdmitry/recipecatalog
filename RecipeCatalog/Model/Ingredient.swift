//
//  Ingredients.swift
//  RecipeCatalog
//
//  Created by Дмитрий Федоринов on 29.10.2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import Foundation
import Firebase

/** Модель объекта Ингредиент, создается по приходяшему с FireBase json */
struct Ingredient {
    let id: String
    let title: String
    var quantity: String?
    let ref: DatabaseReference?
    
    ///from firebase
    init(snapshot: DataSnapshot) {
        let json = snapshot.value as! [String:AnyObject]
        ref = snapshot.ref
        id = json["id"] as! String
        title = json["title"] as! String
        quantity = nil
    }
    
    ///from recipe
    init(id:String, title:String, quantity:String) {
        ref = nil
        self.id = id
        self.title = title
        self.quantity = quantity
    }
    ///from client
    init(title:String, quantity:String) {
        ref = nil
        id = UUID().uuidString
        self.title = title
        self.quantity = quantity
    }
}

