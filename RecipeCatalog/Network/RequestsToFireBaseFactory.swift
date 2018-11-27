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
    func takeListOfRecipes(idCategory: String,
                           completion: @escaping ([Recipe]) -> Void)
    func takeListOfAllParametrs(completion: @escaping ([Ingredient]) -> Void)
    func searchRecipe(with ingredients:[Ingredient], completion: @escaping ([Recipe]) -> Void)
}

/** Класс реализующий запросы к Firebase */
class RequestsToFireBase: RequestsToFireBaseFactory {
    
    
    //MARK: - Private Properties
    
    private var ref: DatabaseReference!
    
    
    //MARK: - Public methods
    
    ///получение списка категорий
    /// - completion - затыкание где будет обработан список категории
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
    
    ///получение списка рецептов
    /// - completion - замыкание где будет обработан список рецептов
    func takeListOfRecipes(with completion: @escaping ([Recipe]) -> Void) {
        ref = Database.database().reference(withPath: " recipes")
        ref.observe(.value) { (snapshot) in
            var recipeArray = [Recipe]()
            for item in snapshot.children {
                let recipe = Recipe(snapshot: item as! DataSnapshot)
                recipeArray.append(recipe)
            }
            
            completion(recipeArray)
        }
    }
    
    ///получение списка рецептов конкретной категории
    /// - completion - замыкание где будет обработан список рецептов
    func takeListOfRecipes(idCategory: String,
                           completion: @escaping ([Recipe]) -> Void) {
        ref = Database.database().reference(withPath: " recipes")
        ref.observe(.value) { (snapshot) in
            var recipeArray = [Recipe]()
            for item in snapshot.children {
                let recipe = Recipe(snapshot: item as! DataSnapshot)
                guard let catArray = recipe.arrayIdOfCategories else {return}
                for id in catArray {
                    if id.id == idCategory {
                       recipeArray.append(recipe)
                    }
                }
            }
            completion(recipeArray)
        }
    }
    
    ///получение списка всех ингредиентов
    /// - completion - замыкание где будет обработан список ингредиентов
    func takeListOfAllParametrs(completion: @escaping ([Ingredient]) -> Void) {
        ref = Database.database().reference(withPath: "ingredients")
        ref.observe(.value) { (snapshot) in
            var ingredientArray = [Ingredient]()
            for item in snapshot.children {
                let ingredient = Ingredient(snapshot: item as! DataSnapshot)
                ingredientArray.append(ingredient)
            }
            completion(ingredientArray)
        }
    }
    
    
    ///получение списка всех реептов с заданными параметрами отсортироваными по принциппу полное совпадение -> совпадение -> частичное совпадение
    /// - completion - замыкание где будет обработан список новых рецептов
    func searchRecipe(with ingredients:[Ingredient], completion: @escaping ([Recipe]) -> Void)  {
        takeListOfRecipes { (recipes) in
            completion(SearchRecipeLogic.search(ingredients: ingredients, recipes: recipes))
        }
    }
    
}
