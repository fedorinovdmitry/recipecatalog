//
//  RecipesTableViewController.swift
//  RecipeCatalog
//
//  Created by Артем Чурсин on 31/10/2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import UIKit

final class RecipesTableViewController: UITableViewController {

    //MARK: - Constants
    //Заглушка для картинок
    private let imageArr = [UIImage(named: "iconsRec"),
                    UIImage(named: "iconsRec2"),
                    UIImage(named: "iconsRec3")]
    
    //MARK: - Variables
    //внедрение делегата по работе с фаербезом
    lazy var delegateWorkWithFirebase: RequestsToFireBaseFactory = NetworkBornFactory().makeRequestsToFireBase()
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
    //подгрузка данных из firebase
    private func workwithFireBase(){
        delegateWorkWithFirebase.takeListOfRecipes { [weak self] (recipes) in
            self?.arrayRec = recipes
            //            for recipe in (self?.arrayRec)! {
            //                print("id - \(recipe.id) title - \(recipe.title)")
            //                print("idCategories - \(recipe.arrayIdOfCategories) idParameters - \(recipe.arrayIdParameters)")
            //                print("text - \(recipe.text)")
            //            }
            self?.recipeTable.reloadData()
        }
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
        
        cell.recipeNameCell.text = arrayRec[indexPath.row].title
        cell.imageViewCell.image = imageArr[indexPath.row]

        return cell
    }
}
