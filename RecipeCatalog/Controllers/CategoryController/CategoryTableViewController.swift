//
//  CategoryTableViewController.swift
//  RecipeCatalog
//
//  Created by Артем Чурсин on 31/10/2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import UIKit

final class CategoryTableViewController: UITableViewController {
    
    
    //MARK: - Private Properties
    
    //внедрение делегата по работе с фаербезом
    lazy var delegateWorkWithFirebase: RequestsToFireBaseFactory = NetworkBornFactory().makeRequestsToFireBase()
    //внедрение делегата по работе с аламофаером
    lazy var delegatWorkWithAlomofire = NetworkBornFactory().makeRequestsToAlomofire()
    
    private var arrayCat = [Category]()
    private var arrayRec = [Recipe]()
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var categoryTable: UITableView!
    
    
    //MARK: - LifeStyle ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTable.backgroundColor = UIColor.backgroundColor
        
        workwithFireBase()
        
        delegateWorkWithFirebase.takeListOfRecipes(idCategory: "102") { (array) in
            print(array)
        }
    }
    
    
    //MARK: - Private methods
    
    private func workwithFireBase(){
        // вывод листа категорий
        delegateWorkWithFirebase.takeListOfCategory { [weak self] (categories) in
            self?.arrayCat = categories
            self?.categoryTable.reloadData()
        }
    }
    
    ///конфигурация ячейки
    /// - indexPath - номер ячейки
    /// - cell - сама ячейка
    private func configCell(with indexPath:Int, cell:CategoryTableViewCell) -> CategoryTableViewCell {
        let category = arrayCat[indexPath]
        cell.imageCell.image = UIImage(named: "noPhoto")
        if let url = category.url {
            delegatWorkWithAlomofire.downloadImage(url: url){ (image) in
                DispatchQueue.main.async {
                    cell.imageCell.image = image
                }
            }
        }
        cell.labelCell.text = arrayCat[indexPath].title
        return cell
    }
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayCat.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        
        return configCell(with: indexPath.row, cell: cell)
    }
    
    
    //MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toListOfRecipe" {
            let destination = segue.destination as? RecipesTableViewController
            if let selectedRow = tableView.indexPathForSelectedRow?.row {
                destination?.idCategory = arrayCat[selectedRow].id
            }
        }
    }
}

