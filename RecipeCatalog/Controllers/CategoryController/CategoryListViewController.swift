//
//  CategoryListViewController.swift
//  RecipeCatalog
//
//  Created by Артем Чурсин on 12/11/2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import UIKit

class CategoryListViewController: UIViewController {
    
    var onCompletion: CompletionBlock?

    //MARK: - Private Properties
    
    //внедрение делегата по работе с фаербезом
    lazy var delegateWorkWithFirebase: RequestsToFireBaseFactory = NetworkBornFactory().makeRequestsToFireBase()
    //внедрение делегата по работе с аламофаером
    lazy var delegatWorkWithAlomofire = NetworkBornFactory().makeRequestsToAlomofire()
    
    private var arrayCat = [Category]()
    private var arrayRec = [Recipe]()
    
    private var roundButton = UIButton()
    
    //MARK: - Outlets
    @IBOutlet weak var categoryTable: UITableView!
    @IBOutlet weak var findButton: UIButton!
    
    //MARK: - LifeStyle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTable.backgroundColor = ThemAppearance.backgroundColor.uiColor()
        
        workwithFireBase()
        
        findButton.createFloatingActionButton()
    }
    
    //MARK: - Private methods
    private func workwithFireBase(){
        // вывод листа категорий
        delegateWorkWithFirebase.takeListOfCategory { [weak self] (categories) in
            self?.arrayCat = categories
            self?.categoryTable.reloadData()
        }
        delegateWorkWithFirebase.takeListOfAllParametrs { [weak self] (ingredients) in
            
//            for i in ingredients {
//                print(i.id)
//            }
            let arr = [Ingredient(id: "10008", title: "соль", quantity: "Много"), Ingredient(id: "10006", title: "Спаггети", quantity: "ыуц"), Ingredient(id: "10009", title: "Бекон", quantity: "ыуц")]
            
            self?.delegateWorkWithFirebase.searchRecipe(with: arr) { (recipes) in
                for i in recipes {
                    print(i.id)
                }
            }
            
        }
    }
    
    ///конфигурация ячейки
    /// - indexPath - номер ячейки
    /// - cell - сама ячейка
    private func configCell(with indexPathRow:Int, cell:CategoryTableViewCell) -> CategoryTableViewCell {
        let category = arrayCat[indexPathRow]
        cell.imageCell.image = UIImage(named: "noPhoto")
        if let url = category.url {
            delegatWorkWithAlomofire.downloadImage(url: url){ (image) in
                DispatchQueue.main.async {
                    cell.imageCell.image = image
                }
            }
        }
        cell.labelCell.text = arrayCat[indexPathRow].title
        return cell
    }

}

extension CategoryListViewController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrayCat.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell
        
        return configCell(with: indexPath.row, cell: cell)
    }
}

extension CategoryListViewController: UITableViewDelegate{
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toListOfRecipe" {
            let destination = segue.destination as? RecipesTableViewController
            if let selectedRow = categoryTable.indexPathForSelectedRow?.row {
                destination?.idCategory = arrayCat[selectedRow].id
            }
        }
    }
}
