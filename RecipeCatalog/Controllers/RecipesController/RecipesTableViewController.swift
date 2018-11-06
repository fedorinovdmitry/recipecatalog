//
//  RecipesTableViewController.swift
//  RecipeCatalog
//
//  Created by Артем Чурсин on 31/10/2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import UIKit

final class RecipesTableViewController: UITableViewController {
    
    //MARK: - Public Properties
    
    var idCategory: String? = nil
    
    
    //MARK: - Variables
    
    //внедрение делегата по работе с фаербезом
    lazy var delegateWorkWithFirebase = NetworkBornFactory().makeRequestsToFireBase()
    //внедрение делегата по работе с Аламофаером
    lazy var delegatWorkWithAlomofire = NetworkBornFactory().makeRequestsToAlomofire()
    
    private var arrayCat = [Category]()
    private var arrayRec = [Recipe]()
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var recipeTable: UITableView!
    
    
    //MARK: - LifeStyle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeTable.backgroundColor = UIColor.backgroundColor
        
        workwithFireBase()
        
        
        
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
    private func configureCell(with indexPath:Int, cell:RecipesTableViewCell) -> RecipesTableViewCell {
        let recipe = arrayRec[indexPath]
        cell.recipeNameCell.text = recipe.title
        cell.imageViewCell.image = UIImage(named: "noPhoto")
        delegatWorkWithAlomofire.downloadImage(url: recipe.url) { (image) in
            DispatchQueue.main.async {
                cell.imageViewCell.image = image
            }
        }
        cell.complexity.text = "Сложность рецепта - " + String(recipe.complexity)
        return cell
    }

    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayRec.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipesCell", for: indexPath) as! RecipesTableViewCell
        
        return configureCell(with: indexPath.row, cell: cell)
    }
    
    
    
    
}
