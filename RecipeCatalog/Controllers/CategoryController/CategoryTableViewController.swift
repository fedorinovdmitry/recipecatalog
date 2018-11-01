//
//  CategoryTableViewController.swift
//  RecipeCatalog
//
//  Created by Артем Чурсин on 31/10/2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import UIKit

final class CategoryTableViewController: UITableViewController {

    //MARK: - Constants
    //Заглушка для картинок
    private let imageArr = [UIImage(named: "Category1"),
                    UIImage(named: "Category2"),
                    UIImage(named: "Category3"),
                    UIImage(named: "Category4"),
                    UIImage(named: "Category5")]
    
    //MARK: - Variables
    //внедрение делегата по работе с фаербезом
    lazy var delegateWorkWithFirebase: RequestsToFireBaseFactory = NetworkBornFactory().makeRequestsToFireBase()
    private var arrayCat = [Category]()
    private var arrayRec = [Recipe]()
    
    //MARK: - Outlets
    @IBOutlet weak var categoryTable: UITableView!
    
    //MARK: - LifeStyle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        categoryTable.backgroundColor = UIColor.backgroundColor
        
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

