//
//  SearchRecipeLogic.swift
//  RecipeCatalog
//
//  Created by Дмитрий Федоринов on 26.11.2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import Foundation

///статус совпадения рецепта (хранит совпвашие ингредиенты)
enum RecipeMatchStatus {
    ///все ингредиенты совпали 1 в 1
    case fullMatch(ingredients: [Ingredient])
    ///все ингредиенты из поиска есть в рецепте, но в рецепте есть еще ингредиенты
    case match(ingredients: [Ingredient])
    ///какая-то часть ингредиентов из поиска совпала с рецептом и возвращает массив совпавших ингредиентов
    case overlap(ingredients: [Ingredient])
    ///ни одного ингредиента не совпало с рецептами
    case noMatch
}

class SearchRecipeLogic {

    static func search(ingredients: [Ingredient],
                       recipes: [Recipe]) -> [Recipe] {
        var fullmatchArr = [Recipe]()
        var matchArr = [Recipe]()
        var overlapArr = [Recipe]()
        for recipe in recipes {
            var recipeContainer = recipe
            let match = checkRecipe(recipe: recipeContainer, ingredients: ingredients)
            recipeContainer.searchMatch = match
            switch match {
            case .fullMatch:
                fullmatchArr.append(recipeContainer)
            case .match:
                matchArr.append(recipeContainer)
            case .overlap:
                overlapArr.append(recipeContainer)
            case .noMatch: break
            }
        }
        
        return fullmatchArr + matchArr + overlapArr
    }
    
    private static func checkRecipe(recipe: Recipe, ingredients: [Ingredient]) -> RecipeMatchStatus {
        guard let ingredientsInRecipeArr = recipe.arrayIdParameters
            else { return .noMatch }
        var meter = 0
        var matchArray = [Ingredient]()
        for ingredient in ingredients {
            if EdditingArray.containsElementInArray(element:ingredient, array:ingredientsInRecipeArr) {
                meter += 1
                matchArray.append(ingredient)
            }
        }
        switch meter {
            case _ where meter == ingredients.count && meter == ingredientsInRecipeArr.count :
                return .fullMatch(ingredients: matchArray)
            case _ where meter == ingredients.count || meter == ingredientsInRecipeArr.count :
                return .match(ingredients: matchArray)
            case _ where meter > 0 && meter < ingredients.count :
                return .overlap(ingredients: matchArray)
            default :
                return .noMatch
        }
    }
    
}
