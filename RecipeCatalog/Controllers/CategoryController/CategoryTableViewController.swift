//
//  CategoryTableViewController.swift
//  RecipeCatalog
//
//  Created by Артем Чурсин on 31/10/2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import UIKit

class CategoryTableViewController: UITableViewController {

    //MARK: - Constants
    
    //Заглушка для картинок
    let imageArr = [UIImage(named: "Category1"),
                    UIImage(named: "Category2"),
                    UIImage(named: "Category3"),
                    UIImage(named: "Category4"),
                    UIImage(named: "Category5")]
    
    //MARK: - Variables
    
    //внедрение делегата по работе с фаербезом
    lazy var delegateWorkWithFirebase: RequestsToFireBaseFactory = NetworkBornFactory().makeRequestsToFireBase()
    var arrayCat = [Category]()
    var arrayRec = [Recipe]()
    
    //MARK: - Outlets
    
    @IBOutlet var categoryTable: UITableView!
    
    //MARK: - LifeStyle ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTable.backgroundColor = hexStringToUIColor(hex: "#95C595")
        
        workwithFireBase()
    }
    
    //MARK: - Private methods
    
    private func workwithFireBase(){
        // тестовый вывод листа категорий
        delegateWorkWithFirebase.takeListOfCategory { [weak self] (categories) in
            self?.arrayCat = categories
            //            for category in (self?.arrayCat)! {
            //                print("id - \(category.id) title - \(category.title)")
            //            }
            self?.categoryTable.reloadData()
        }
    }
    
    // Преобразование HEX цвета в UIColor
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
        
        return arrayCat.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath) as! CategoryTableViewCell

        cell.imageCell.image = imageArr[indexPath.row]
        cell.labelCell.text = arrayCat[indexPath.row].title
        
        return cell
    }
}
