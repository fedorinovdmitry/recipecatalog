//
//  RecipesTableViewController.swift
//  RecipeCatalog
//
//  Created by Артем Чурсин on 31/10/2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import UIKit

class RecipesTableViewController: UIViewController {
    
    //MARK: - Public Properties
    
    var idCategory: String? = nil
    var isSearch: Bool = false
    var arrayRec = [Recipe]()
    
    
    //MARK: - Variables
    //внедрение делегата по работе с фаербезом
    lazy var delegateWorkWithFirebase = NetworkBornFactory().makeRequestsToFireBase()
    //внедрение делегата по работе с Аламофаером
    lazy var delegatWorkWithAlomofire = NetworkBornFactory().makeRequestsToAlomofire()
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var recipeTable: UITableView!
    @IBOutlet weak var findButton: UIButton!
    
    
    //MARK: - LifeStyle ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeTable.backgroundColor = ThemAppearance.backgroundColor.uiColor()
        
        findButton.createFloatingActionButton()
        
        if isSearch == false {
            workwithFireBase()
        }else {
            findButton.isHidden = true
        }
    }
    
    //MARK: - Private methods
    ///подгрузка данных из firebase
    private func workwithFireBase() {
        if let id = idCategory {
            delegateWorkWithFirebase.takeListOfRecipes(idCategory: id) { [weak self] (recipes) in
                self?.arrayRec = recipes
                self?.recipeTable.reloadData()
            }
        }
    }
    
    ///конфигурация ячейки
    /// - indexPath - номер ячейки
    /// - cell - сама ячейка
    private func configureCell(with indexPathRow:Int, cell:RecipesTableViewCell) -> RecipesTableViewCell {
        let recipe = arrayRec[indexPathRow]
        var ingridShortList = "Основные ингридиенты: "
        cell.recipeNameCell.text = recipe.title
        cell.imageViewCell.image = UIImage(named: "noPhoto")
        delegatWorkWithAlomofire.downloadImage(url: recipe.url) { (image) in
            DispatchQueue.main.async {
                cell.imageViewCell.image = image
            }
        }
        
        if let ingridients = recipe.arrayIdParameters {
            for ingrid in 0...ingridients.count - 1 {
                if ingrid < 2 {
                    ingridShortList = ingridShortList + ingridients[ingrid].title
                }
                if ingrid == 1 || ingrid == ingridients.count - 1 {
                    ingridShortList = ingridShortList + "."
                    break
                }
                else {
                    ingridShortList = ingridShortList + ", "
                }
            }
        }
        cell.ingredientsNamesCell.text = ingridShortList
        
        complexitySwitch(complexity: recipe.complexity, cell: cell)
        
        
        return cell
    }
    
    private func complexitySwitch(complexity: Int, cell: RecipesTableViewCell) {
        switch complexity {
        case 1:
            cell.beer1.image = UIImage(named: "ActiveDarkBeer")
        case 2:
            cell.beer1.image = UIImage(named: "ActiveDarkBeer")
            cell.beer2.image = UIImage(named: "ActiveDarkBeer")
        case 3:
            cell.beer1.image = UIImage(named: "ActiveDarkBeer")
            cell.beer2.image = UIImage(named: "ActiveDarkBeer")
            cell.beer3.image = UIImage(named: "ActiveDarkBeer")
        case 4:
            cell.beer1.image = UIImage(named: "ActiveDarkBeer")
            cell.beer2.image = UIImage(named: "ActiveDarkBeer")
            cell.beer3.image = UIImage(named: "ActiveDarkBeer")
            cell.beer4.image = UIImage(named: "ActiveDarkBeer")
        case 5:
            cell.beer1.image = UIImage(named: "ActiveDarkBeer")
            cell.beer2.image = UIImage(named: "ActiveDarkBeer")
            cell.beer3.image = UIImage(named: "ActiveDarkBeer")
            cell.beer4.image = UIImage(named: "ActiveDarkBeer")
            cell.beer5.image = UIImage(named: "ActiveDarkBeer")
        default:
            print("Oooops")
        }
    }
}

extension RecipesTableViewController: UITableViewDataSource {
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
    
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayRec.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesCell", for: indexPath) as! RecipesTableViewCell
        
        return configureCell(with: indexPath.row, cell: cell)
    }
}

extension RecipesTableViewController: UITableViewDelegate {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toRecipe" {
            let destination = segue.destination as? RecipeMainConrollerTableViewController
            if let selectedRow = recipeTable.indexPathForSelectedRow?.row {
                destination?.recipe = arrayRec[selectedRow]
            }
        }
    }
}

extension RecipesTableViewController: UITabBarDelegate {
    
}
