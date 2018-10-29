//
//  RequestsToFireBaseFactory.swift
//  RecipeCatalog
//
//  Created by Дмитрий Федоринов on 29.10.2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import Foundation
import Firebase

/** Фабрика запросов к Фаербейсу */
protocol RequestsToFireBaseFactory {
    func takeListOfCategory(with completion: @escaping ([Category]) -> Void)
    func takeListOfRecipes(with completion: @escaping ([Recipe]) -> Void)
}
/** Фабрика сетевых запросов */
class NetworkBornFactory {
    func makeRequestsToFireBase () -> RequestsToFireBaseFactory {
        return RequestsToFireBase()
    }
}
/** Класс реализующий запросы к Firebase */
class RequestsToFireBase: RequestsToFireBaseFactory {
    
    
    //MARK: - Private Properties
    
    private var ref: DatabaseReference!
    
    
    //MARK: - Public methods
    
    func takeListOfCategory(with completion: @escaping ([Category]) -> Void) {
        ref = Database.database().reference(withPath: "categories")
        ref.observe(.value) { (snapshot) in
            var categoriesArray = Array<Category>()
            for item in snapshot.children {
                let category = Category(snapshot: item as! DataSnapshot)
                categoriesArray.append(category)
            }
            completion(categoriesArray)
        }
    }
    func takeListOfRecipes(with completion: @escaping ([Recipe]) -> Void) {
        ref = Database.database().reference(withPath: " recipes")
        ref.observe(.value) { (snapshot) in
            var recipeArray = Array<Recipe>()
            for item in snapshot.children {
                let recipe = Recipe(snapshot: item as! DataSnapshot)
                recipeArray.append(recipe)
            }
            completion(recipeArray)
        }
    }
    
}
