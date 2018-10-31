//
//  RecipesTableViewController.swift
//  RecipeCatalog
//
//  Created by Артем Чурсин on 31/10/2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import UIKit

class RecipesTableViewController: UITableViewController {

    
    //MARK: - Constants
    
    //Заглушка для картинок
    let imageArr = [UIImage(named: "iconsRec"),
                    UIImage(named: "iconsRec2"),
                    UIImage(named: "iconsRec3")]
    
    //MARK: - Variables
    
    //внедрение делегата по работе с фаербезом
    lazy var delegateWorkWithFirebase: RequestsToFireBaseFactory = NetworkBornFactory().makeRequestsToFireBase()
    var arrayCat = [Category]()
    var arrayRec = [Recipe]()
    
    //MARK: - Outlets
    
    @IBOutlet var recipeTable: UITableView!
    
    //MARK: - LifeStyle ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recipeTable.backgroundColor = hexStringToUIColor(hex: "#95C595")
        
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
    
    //преобразование цыета из hex
    private func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
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
