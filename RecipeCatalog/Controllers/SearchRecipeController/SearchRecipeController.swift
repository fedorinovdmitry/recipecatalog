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
    // Dima table stub
    @IBOutlet weak var ingredientsTable: UITableView!
    @IBOutlet weak var searchBut: UIButton!
    
    //Outlet
    @IBOutlet weak var myProductsTitle: UILabel!
    @IBOutlet weak var myProductsText: UITextView!
    @IBOutlet weak var myProductsMask: UIView!
    @IBOutlet weak var serchScreenBackground: UIView!
    @IBOutlet weak var findButton: UIButton!
    
    //Artem image stub
    @IBOutlet weak var beer: UIImageView!
    @IBOutlet weak var chicken: UIImageView!
    @IBOutlet weak var fish: UIImageView!
    @IBOutlet weak var luk: UIImageView!
    @IBOutlet weak var ris: UIImageView!
    @IBOutlet weak var water: UIImageView!
    @IBOutlet weak var becon: UIImageView!
    @IBOutlet weak var egg: UIImageView!
    @IBOutlet weak var slivki: UIImageView!
    @IBOutlet weak var solt: UIImageView!
    @IBOutlet weak var sosyski: UIImageView!
    @IBOutlet weak var spagetty: UIImageView!
    
    
    //MARK: - Private Properties
    
    //внедрение делегата по работе с фаербезом
    private lazy var delegateWorkWithFirebase: RequestsToFireBaseFactory = NetworkBornFactory().makeRequestsToFireBase()
    //внедрение делегата по работе с аламофаером
    private lazy var delegatWorkWithAlomofire = NetworkBornFactory().makeRequestsToAlomofire()
    
    var fileViewOrigin: CGPoint!
    
    private var allIngredientArr = [Ingredient]()
    private var choseIngredientArr = [Ingredient]()
    private var searchRecipes = [Recipe]()

    private enum FireBaseWork {
        case searchRecipe
        case downloadIngredients
    }
    //MARK: - LifeStyle ViewController
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        findButton.layer.cornerRadius = 20
        myProductsMask.layer.cornerRadius = 40
        myProductsText.layer.cornerRadius = 30
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
        workwithFireBase(workWith: .downloadIngredients)
        
        
        
//        beer.image = UIImage(named: "Beer")
//        if beer.image == UIImage(named: "Beer") {
//            print("lkmlkjlhiohlkjnydutfgyibuhnj")
//        }
        
        addPanGesture(view: beer)
        fileViewOrigin = beer.frame.origin
        view.bringSubviewToFront(beer)
    }
    
    //MARK: - IBAction
    
    @IBAction func searchAction(_ sender: Any) {
        workwithFireBase(workWith: .searchRecipe)
    }
    
    
    //MARK: - Private methods
    private func setupScreen() {
        serchScreenBackground.backgroundColor = ThemAppearance.backgroundColor.uiColor()
        myProductsMask.backgroundColor = ThemAppearance.backgroundCellColor.uiColor()
        findButton.backgroundColor = ThemAppearance.backgroundButtonColor.uiColor()
        findButton.tintColor = ThemAppearance.textColor.uiColor()
        
        myProductsTitle.textColor = ThemAppearance.textColor.uiColor()
        myProductsText.backgroundColor = ThemAppearance.backgroundButtonColor.uiColor()
        myProductsText.tintColor = ThemAppearance.textColor.uiColor()
    }
    
    private func addPanGesture(view: UIView) {
        let pan = UIPanGestureRecognizer(target: self, action: #selector(SearchRecipeController.handlePan(sender:)))
        view.addGestureRecognizer(pan)
    }
    
    @objc private func handlePan(sender: UIPanGestureRecognizer) {
        
        let fileView = sender.view!
        
        switch sender.state {
        case .began, .changed:
            moveViewWithPan(view: fileView, sender: sender)
        case .ended:
            if fileView.frame.intersects(myProductsMask.frame) {
                deleteView(view: fileView)
            }
            else {
                returnViewToOrigin(view: fileView)
            }
        default:
            break
        }
    }
    
    private func moveViewWithPan(view: UIView, sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        
        view.center = CGPoint(x: view.center.x + translation.x,
                              y: view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
    }
    
    private func returnViewToOrigin(view: UIView) {
        UIView.animate(withDuration: 0.3, animations: {view.frame.origin = self.fileViewOrigin})
    }
    
    private func deleteView(view: UIView) {
        UIView.animate(withDuration: 0.3, animations: {view.alpha = 0.0})
       
        if let check = view as? UIImageView {
            if check.image == UIImage(named: "Beer") {
                for inggrid in allIngredientArr {
                    if inggrid.title == "Пиво" {
                        choseIngredientArr.append(inggrid)
                        myProductsText.text = myProductsText.text + inggrid.title + "\n"
                    }
                }
            }
        }
    }
    
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
                print(self!.allIngredientArr)
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
