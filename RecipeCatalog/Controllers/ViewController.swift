//
//  ViewController.swift
//  RecipeCatalog
//
//  Created by Дмитрий Федоринов on 29.10.2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //внедрение делегата по работе с фаербезом
    lazy var delegateWorkWithFirebase: RequestsToFireBaseFactory = NetworkBornFactory().makeRequestsToFireBase()
    var arrayCat = [Category]()
    var arrayRec = [Recipe]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // тестовый вывод листа категорий
        delegateWorkWithFirebase.takeListOfCategory { [weak self] (categories) in
            self?.arrayCat = categories
            for category in (self?.arrayCat)! {
                print("id - \(category.id) title - \(category.title)")
            }
        }
        
        // тестовый вывод листа рецептов
        delegateWorkWithFirebase.takeListOfRecipes { [weak self] (recipes) in
            self?.arrayRec = recipes
            for recipe in (self?.arrayRec)! {
                print("id - \(recipe.id) title - \(recipe.title)")
                print("idCategories - \(recipe.arrayIdOfCategories) idParameters - \(recipe.arrayIdParameters)")
                print("text - \(recipe.text)")
            }
        }
        
        
        
        
    }


}

