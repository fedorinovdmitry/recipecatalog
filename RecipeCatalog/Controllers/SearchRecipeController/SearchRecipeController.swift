//
//  SearchRecipeController.swift
//  RecipeCatalog
//
//  Created by Дмитрий Федоринов on 27.11.2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import UIKit

class SearchRecipeController: UIViewController {
    
    
    //MARK: - Outlets
    
    @IBOutlet weak var ingredientsTable: UITableView!
    @IBOutlet weak var searchBut: UIButton!
    
    
    //MARK: - Private Properties
    
    //внедрение делегата по работе с фаербезом
    private lazy var delegateWorkWithFirebase: RequestsToFireBaseFactory = NetworkBornFactory().makeRequestsToFireBase()
    //внедрение делегата по работе с аламофаером
    private lazy var delegatWorkWithAlomofire = NetworkBornFactory().makeRequestsToAlomofire()
    
    private var allIngredientArr = [Ingredient]()
    private var choseIngredientArr = [Ingredient]()
    private var searchRecipes = [Recipe]()

    private enum FireBaseWork {
        case searchRecipe
        case downloadIngredients
    }
    //MARK: - LifeStyle ViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        workwithFireBase(workWith: .downloadIngredients)
        
    }
    
    
    //MARK: - IBAction
    
    @IBAction func searchAction(_ sender: Any) {
        workwithFireBase(workWith: .searchRecipe)
    }
    
    
    //MARK: - Private methods
    
    private func workwithFireBase(workWith: FireBaseWork){
        switch workWith {
        case .searchRecipe:
            delegateWorkWithFirebase.searchRecipe(with: choseIngredientArr) { [weak self] (recipes) in
                self?.searchRecipes = recipes
                self?.performSegue(withIdentifier: "toListSearchRecipes", sender: self)
            }
        case .downloadIngredients:
            delegateWorkWithFirebase.takeListOfAllParametrs { [weak self] (ingredients) in
                self?.allIngredientArr = ingredients
                self?.ingredientsTable.reloadData()
            }
        }

    }
    
    private func configCell(with indexPathRow:Int, cell:SearchRecipeIngredientTableCell) -> SearchRecipeIngredientTableCell {
        let ingredient = allIngredientArr[indexPathRow]
        cell.title.text = ingredient.title
        return cell
    }

}


// MARK: - Table view data source

extension SearchRecipeController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allIngredientArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchRecipeIngredientTableCell
        
        return configCell(with: indexPath.row, cell: cell)
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        choseIngredientArr.append(allIngredientArr[indexPath.row])
        self.showAlert(title: "Добавлен")
    }
}

extension SearchRecipeController: UITableViewDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toListSearchRecipes" {
            let destination = segue.destination as? RecipesTableViewController

            destination?.arrayRec = searchRecipes
            destination?.isSearch = true

        }
    }
    
}
