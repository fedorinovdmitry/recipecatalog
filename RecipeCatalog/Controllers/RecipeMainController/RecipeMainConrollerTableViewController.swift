//
//  RecipeMainConrollerTableViewController.swift
//  RecipeCatalog
//
//  Created by Артем Чурсин on 07/11/2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import UIKit

class RecipeMainConrollerTableViewController: UIViewController {

    //MARK: - Constants
    let arrayRec = [("Beer, beer beer", "1:15:00"), ("One, two, one", "1:30:00")]
    //MARK: - Variables
    var isRecipeActive = false
    
    //MARK: - Outlets
    @IBOutlet weak var recipeTable: UITableView!
    
    //MARK: - LifeStyle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTable.backgroundColor = ThemAppearance.backgroundColor.uiColor()
    }
    
    //MARK: - Private methods
    
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
        cell.timerLableCell.text = recipe.1
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
        
        let cell0 = tableView.dequeueReusableCell(withIdentifier: "recipeTitleCell", for: indexPath) as! RecipeTitleTableViewCell
        
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageRecipeTableViewCell
        
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "IngridientsCell", for: indexPath) as! IngridientsTableViewCell
        
        let cell3 = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeTableViewCell
        
        switch indexPath.row {
        case 0:
//            return configureTitleCell(with: indexPath.row, cell: cell0)
            return cell0
        case 1:
            return cell1
        case 2:
            return cell2
        case 3...:
            return configurePartCell(with: indexPath.row, cell: cell3)
        default:
            print("error")
        }
        return cell1
    }
}
