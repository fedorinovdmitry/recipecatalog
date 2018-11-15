//
//  RecipeMainConrollerTableViewController.swift
//  RecipeCatalog
//
//  Created by Артем Чурсин on 07/11/2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import UIKit

class RecipeMainConrollerTableViewController: UIViewController {

    let arrayRec = [("Beer, beer beer", "1:15:00"), ("One, two, one", "1:30:00")]
    
    //MARK: - Outlets
    @IBOutlet weak var recipeTable: UITableView!
    
    //MARK: - LifeStyle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeTable.backgroundColor = ThemAppearance.backgroundColor.uiColor()
    }
    
    //MARK: - Private methods
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageRecipeTableViewCell
        
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "IngridientsCell", for: indexPath) as! IngridientsTableViewCell
        
        let cell2 = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeTableViewCell
        
        switch indexPath.row {
        case 0:
            return cell
        case 1:
            return cell1
        case 2...:
            return configurePartCell(with: indexPath.row, cell: cell2)
        default:
            print("error")
        }
        return cell
    }
}
