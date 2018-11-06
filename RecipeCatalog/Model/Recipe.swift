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
    
    let id: String
    let title: String
    let text: String
    let complexity: Int
    let url: String
    var arrayIdOfCategories: [Category]? = nil
    var arrayIdParameters: [Ingredient]? = nil
    
    /// - parameter snapshot: снимок бд в json формате
    init(snapshot: DataSnapshot) {
        let json = snapshot.value as! [String:AnyObject]
        ref = snapshot.ref
        id = json["id"] as! String
        title = json["title"] as! String
        text = json["text"] as! String
        complexity = json["complexity"] as! Int
        url = json["url"] as! String
        arrayIdOfCategories = self.getArrayofId(categories: json["idCategories"] as! [String:AnyObject])
        arrayIdParameters = self.getArrayofId(parameters: json["idParameters"] as! [String:AnyObject])
    }
    
    /// Парсит джсон категории
    /// - parameter categories: снимок пункта категории в рецепте в json формате
    private func getArrayofId(categories:[String:AnyObject]) -> [Category] {
        var array = [Category]()
        for dicId in categories {
            let dicContainer = dicId.value as! [String:AnyObject]
            let id = dicContainer["id"] as! String
            let title = dicContainer["title"] as! String
            array.append(Category(id: id, title: title))
        }
        return array
    }
    
    /// Парсит джсон параметров
    /// - parameter parameters: снимок пункта параметры в рецепте в json формате
    private func getArrayofId(parameters:[String:AnyObject]) -> [Ingredient] {
        var array = [Ingredient]()
        for dicId in parameters {
            let dicContainer = dicId.value as! [String:AnyObject]
            let id = dicContainer["id"] as! String
            let quantity = dicContainer["quantity"] as! String
            let title = dicContainer["title"] as! String
            array.append(Ingredient(id: id, title: title, quantity: quantity))
        }
        return array
    }
    
}
