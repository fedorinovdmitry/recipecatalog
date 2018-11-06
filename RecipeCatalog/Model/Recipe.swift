//
//  Recipe.swift
//  RecipeCatalog
//
//  Created by Дмитрий Федоринов on 29.10.2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import Foundation
import Firebase
//TODO: сделать хренение параметра объектом с запросом к бд
/** Модель объекта Рецепт, создается по приходяшему с FireBase json */
struct Recipe {
    
    // путь в бд к этому объекту
    let ref: DatabaseReference
    
    let id: Int
    let title: String
    let text: String
    let complexity: Int
    var arrayIdOfCategories: [Int]? = nil
    var arrayIdParameters: [(Int,String)]? = nil
    
    /// - parameter snapshot: снимок бд в json формате
    init(snapshot: DataSnapshot) {
        let json = snapshot.value as! [String:AnyObject]
        ref = snapshot.ref
        id = json["id"] as! Int
        title = json["title"] as! String
        text = json["text"] as! String
        complexity = json["complexity"] as! Int
        arrayIdOfCategories = self.getArrayofId(categories: json["idCategories"] as! [String:AnyObject])
        arrayIdParameters = self.getArrayofId(parameters: json["idParameters"] as! [String:AnyObject])
    }
    
    /// Парсит джсон категории
    /// - parameter categories: снимок пункта категории в рецепте в json формате
    private func getArrayofId(categories:[String:AnyObject]) -> [Int] {
        var array = Array<Int>()
        for dicId in categories {
            let dicIdContainer = dicId.value as! [String:AnyObject]
            let id = dicIdContainer["id"] as! Int
            array.append(id)
        }
        return array
    }
    
    /// Парсит джсон параметров
    /// - parameter parameters: снимок пункта параметры в рецепте в json формате
    private func getArrayofId(parameters:[String:AnyObject]) -> [(Int,String)] {
        var array = Array<(Int,String)>()
        for dicId in parameters {
            let dicIdContainer = dicId.value as! [String:AnyObject]
            let id = dicIdContainer["id"] as! Int
            let quantity = dicIdContainer["quantity"] as! String
            array.append((id,quantity))
        }
        return array
    }
    
}
