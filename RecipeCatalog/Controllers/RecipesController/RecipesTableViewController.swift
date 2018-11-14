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
    
    //MARK: - Variables
    
    //внедрение делегата по работе с фаербезом
    lazy var delegateWorkWithFirebase = NetworkBornFactory().makeRequestsToFireBase()
    //внедрение делегата по работе с Аламофаером
    lazy var delegatWorkWithAlomofire = NetworkBornFactory().makeRequestsToAlomofire()
    
    private var arrayCat = [Category]()
    private var arrayRec = [Recipe]()
    
    //MARK: - Outlets
    
    @IBOutlet weak var recipeTable: UITableView!
    
    @IBOutlet weak var findButton: UIButton!
    //MARK: - LifeStyle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeTable.backgroundColor = UIColor.backgroundColor
        findButton.createFloatingActionButton()
        
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
        
        //TODO: - убрать этот мусор
        //Ето костыль, не ругайте меня больно
        switch recipe.complexity {
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
        
        
//        cell.complexity.text = "Сложность рецепта - " + String(recipe.complexity)

        
        return cell
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

extension RecipesTableViewController: UITabBarDelegate{
    
}
