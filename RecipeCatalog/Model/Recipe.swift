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
    
    let complexity: Int
    let url: String
    var arrayIdOfCategories: [Category]? = nil
    var arrayIdParameters: [Ingredient]? = nil
    private var arrayOfSteps: [Step]? = nil
    
    var searchMatch: RecipeMatchStatus = .noMatch
    
    /// - parameter snapshot: снимок бд в json формате
    init(snapshot: DataSnapshot) {
        let json = snapshot.value as! [String:AnyObject]
        ref = snapshot.ref
        id = json["id"] as! String
        title = json["title"] as! String

        complexity = json["complexity"] as! Int
        url = json["url"] as! String
        if let jsonCat = json["idCategories"] as? [String:AnyObject] {
            arrayIdOfCategories = self.getArrayofId(categories: jsonCat)
        }
        if let jsonPar = json["idParameters"] as? [String:AnyObject] {
            arrayIdParameters = self.getArrayofId(parameters: jsonPar)
        }
        if let jsonStep = json["steps"] as? [String:AnyObject] {
            arrayOfSteps = self.getArrayOfSteps(steps: jsonStep)
        }
        
    }
    /// возвращает структурированый массив с шагами рецепта по порядку
    func getStepArray () -> [Step] {
        let arr: [Step] = [Step]()
        if let arrayOfSteps = self.arrayOfSteps {
            return arrayOfSteps.sorted()
        }
        return arr
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
        return array.sorted()
    }
    /// Парсит джсон шагов
    /// - parameter steps: снимок пункта шаги в рецепте в json формате
    private func getArrayOfSteps(steps:[String:AnyObject]) -> [Step] {
        var array = [Step]()
        for dicId in steps {
            let dicContainer = dicId.value as! [String:AnyObject]
            let number = dicContainer["number"] as! Int
            let img = dicContainer["img"] as? String
            let text = dicContainer["text"] as! String
            let time = dicContainer["time"] as? Int
            
            array.append(Step(number: number, img: img, text: text, time: time))
        }
        return array
    }
    
}
extension Recipe: Equatable{
    static func == (lhs: Recipe, rhs: Recipe) -> Bool{
        return lhs.id == rhs.id
    }
}
