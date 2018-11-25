//
//  Step.swift
//  RecipeCatalog
//
//  Created by Дмитрий Федоринов on 25.11.2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import Foundation

/** Модель объекта Шага рецепта, создается по приходяшему с FireBase json */
struct Step {
    let number: Int
    let img: String?
    let text: String
    let time: Int?
    
    ///from recipe
    init(number:Int, img:String?, text:String, time:Int?) {
        self.number = number
        self.img = img
        self.text = text
        self.time = time
    }
}
