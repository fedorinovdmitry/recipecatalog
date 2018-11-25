//
//  RecipeMainConrollerTableViewController.swift
//  RecipeCatalog
//
//  Created by Артем Чурсин on 07/11/2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import UIKit

final class RecipeMainConrollerTableViewController: UIViewController {


    //MARK: - Constants
    
    let arrayRec = [("Beer, beer beer", "1:15:00"), ("One, two, one", "1:30:00")]
    
    
    //MARK: - Variables
    
    private var isRecipeActive = false
    private var isTimerActive = false
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var recipeTable: UITableView!

    @IBOutlet weak var timerConstraint: NSLayoutConstraint!
    
    
    //MARK: - Public Properties
    
    var recipe: Recipe? = nil
    
    //MARK: - LifeStyle ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTable.backgroundColor = ThemAppearance.backgroundColor.uiColor()
        
        if let recipe = recipe{
            print(recipe.title)
            if let catArr = recipe.arrayIdOfCategories {
                print("категории рецепта:")
                for cat in catArr {
                    print(cat)
                }
            }
            if let parArr = recipe.arrayIdParameters {
                print("ингредиенты рецепта:")
                for par in parArr {
                    print(par)
                }
            }
            
            print("шаги рецепта:")
            for step in recipe.getStepArray() {
                print(step)
            }
            
            
        }
        
    }
    
    
    //MARK: - Private methods
    
    private func showTimer() {
        timerConstraint.constant = 0
        
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
    }
    
    private func configureTitleCell(with indexPath:Int, cell:RecipeTitleTableViewCell) -> RecipeTitleTableViewCell {
        
        if isRecipeActive {
            cell.letCookButton.setTitle("Прекратить готовить", for: .normal)
            showTimer()
        }
        else {
            cell.letCookButton.setTitle("Приготовить", for: .normal)
        }
        return cell
    }
    
    @IBAction func activateRecButton(_ sender: Any) {
        if isRecipeActive {
            isRecipeActive = false
        }
        else {
            isRecipeActive = true
        }
        recipeTable.reloadData()
    }
        
    private func configurePartCell(with indexPath:Int, cell:RecipeTableViewCell) -> RecipeTableViewCell {
        
        cell.titleLableCell.text = "Этап " + String(indexPath - 1)
        let recipe = arrayRec[indexPath-2]
        cell.recipetLableCell.text = recipe.0
        
        return cell
    }
}


// MARK: - Table view data source

extension RecipeMainConrollerTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 4
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // демонстрация ячеек
        
        let titleCell = tableView.dequeueReusableCell(withIdentifier: "recipeTitleCell", for: indexPath) as! RecipeTitleTableViewCell
        
        let imageCell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageRecipeTableViewCell
        
        let ingridientsCell = tableView.dequeueReusableCell(withIdentifier: "IngridientsCell", for: indexPath) as! IngridientsTableViewCell
        
        let recipeCell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeTableViewCell
        
        switch indexPath.row {
        case 0:
            return configureTitleCell(with: indexPath.row, cell: titleCell)
        case 1:
            return imageCell
        case 2:
            return ingridientsCell
        case 3...:
            return configurePartCell(with: indexPath.row, cell: recipeCell)
        default:
            print("error")
        }
        return titleCell
    }
}
