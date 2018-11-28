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
    //Outlet
    @IBOutlet weak var searchBut: UIButton!
    @IBOutlet weak var myProductsTitle: UILabel!
    @IBOutlet weak var myProductsText: UITextView!
    @IBOutlet weak var myProductsMask: UIView!
    @IBOutlet weak var serchScreenBackground: UIView!
    @IBOutlet weak var findButton: UIButton!
    @IBOutlet weak var tutorText: UILabel!
    
    //image stub
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
        
        
        namNeStatProgramistami()
        fileViewOrigin = beer.frame.origin
        
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
        myProductsText.textColor = ThemAppearance.textColor.uiColor()
        tutorText.textColor = ThemAppearance.textColor.uiColor()
    }
    
    func addPanGesture(view: UIView) {
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
        guard let check = view as? UIImageView,
            let id = check.accessibilityValue,
            let ingredient = giveById(id: id)
            else { return }
        choseIngredientArr.append(ingredient)
        myProductsText.text = myProductsText.text + ingredient.title + "\n"
    }
    
    private func giveById(id:String) -> Ingredient? {
        for ingredient in allIngredientArr {
            if id == ingredient.id {
                return ingredient
            }
        }
        return nil
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
            }
        }
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

//жеская заглушка не смотрите на этот код пожалуйста...
//TODO: Разобраться со скролвью в совокупности с тапрекогназером и УДАЛИТЬ НАХРЕН ЭТОТ КОД !!!!
//extension SearchRecipeController {
//    func namNeStatProgramistami() {
//        beer.accessibilityValue = "10003"
//        chicken.accessibilityValue = "10002"
//        fish.accessibilityValue = "10021"
//        luk.accessibilityValue = "10004"
//        ris.accessibilityValue = "10005"
//        water.accessibilityValue = "10001"
//        becon.accessibilityValue = "10009"
//        egg.accessibilityValue = "10011"
//        slivki.accessibilityValue = "10010"
//        solt.accessibilityValue = "10008"
//        sosyski.accessibilityValue = "10007"
//        spagetty.accessibilityValue = "10006"
//        addPanGesture(view: beer)
//        addPanGesture(view: chicken)
//        addPanGesture(view: fish)
//        addPanGesture(view: luk)
//        addPanGesture(view: ris)
//        addPanGesture(view: water)
//        addPanGesture(view: becon)
//        addPanGesture(view: slivki)
//        addPanGesture(view: solt)
//        addPanGesture(view: sosyski)
//        addPanGesture(view: spagetty)
//        addPanGesture(view: egg)
//        view.bringSubviewToFront(beer)
//        view.bringSubviewToFront(chicken)
//        view.bringSubviewToFront(fish)
//        view.bringSubviewToFront(luk)
//        view.bringSubviewToFront(ris)
//        view.bringSubviewToFront(water)
//        view.bringSubviewToFront(becon)
//        view.bringSubviewToFront(egg)
//        view.bringSubviewToFront(slivki)
//        view.bringSubviewToFront(solt)
//        view.bringSubviewToFront(sosyski)
//        view.bringSubviewToFront(spagetty)
//    }
//}
