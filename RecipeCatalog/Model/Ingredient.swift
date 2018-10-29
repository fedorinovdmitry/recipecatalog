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
    let id: Int
    let title: String
    let ref: DatabaseReference
}

