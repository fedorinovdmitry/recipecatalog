//
//  RecipeMainConrollerTableViewController.swift
//  RecipeCatalog
//
//  Created by Артем Чурсин on 07/11/2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import UIKit

final class RecipeMainConrollerTableViewController: UIViewController {
    //MARK: - Constants
    
    //MARK: - Variables
    
    private var isRecipeActive = false
    private var isTimerActive = false
    private var timer = Timer()
    private var timeInSeconds = 0
    private var resumeTapped = false
    
    private var ingridiends: [Ingredient] = []
    private var steps: [Step] = []
    
    //MARK: - Outlets
    
    @IBOutlet weak var recipeTable: UITableView!
    
    @IBOutlet weak var timerConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var stepLable: UILabel!
    @IBOutlet weak var timerLable: UILabel!
    
    @IBOutlet weak var backgroundTimerView: UIView!
    @IBOutlet weak var maskView: UIView!
    
    @IBOutlet weak var done: UIButton!
    @IBOutlet weak var pause: UIButton!
    
    //MARK: - Public Properties
    var recipe: Recipe? = nil
    lazy var delegatWorkWithAlomofire = NetworkBornFactory().makeRequestsToAlomofire()
    
    //MARK: - LifeStyle ViewController
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let buttonRadius: CGFloat = 20
        
        done.layer.cornerRadius = buttonRadius
        pause.layer.cornerRadius = buttonRadius
        
        maskView.layer.cornerRadius = 30
        maskView.layer.shadowOpacity = 0.4
        maskView.layer.shadowRadius = 5
        maskView.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureController()
        
    }
    
    
    //MARK: - Private methods
    
    private func configureController() {
        recipeTable.backgroundColor = ThemAppearance.backgroundColor.uiColor()
        cellTimerSetup()
        if let recipe = recipe{
            self.navigationItem.title = recipe.title
            if let parArr = recipe.arrayIdParameters {
                ingridiends = parArr
            }
            steps = recipe.getStepArray()
            recipeTable.reloadData()
        }
    }
    
    private func cellTimerSetup() {
        
        backgroundTimerView.backgroundColor = UIColor.clear
        maskView.backgroundColor = ThemAppearance.backgroundCellColor.uiColor()
        
        stepLable.textColor = ThemAppearance.textColor.uiColor()
        timerLable.textColor = ThemAppearance.textColor.uiColor()
    }
    
    //MARK: - TIMER
    //TODO: - вынести таймер из контроллера
    @objc func initTimer(sender: AnyObject) {
        if let getTime = sender.tag {
            timeInSeconds = getTime
            if !isTimerActive {
                runTimer()
            }
        }
    }
    
    private func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(RecipeMainConrollerTableViewController.timerSetting), userInfo: nil, repeats: true)
        isTimerActive = true
    }
    
    @objc private func timerSetting(){
        
        if timeInSeconds > 0 {
            timerLable.text = timerConstructor(initSeconds: timeInSeconds)
            timeInSeconds -= 1
        }
    }
    
    private func timerConstructor(initSeconds: Int) -> String {
        
        var hours = 0
        var minuts = 0
        var seconds = 0
        var tmp = 0
        
        seconds = initSeconds % 60
        tmp = initSeconds / 60
        minuts = tmp % 60
        hours = tmp / 60
        
        return toStringTimer(hours) + ":" + toStringTimer(minuts) + ":" + toStringTimer(seconds)
    }
    
    private func toStringTimer(_ timePart: Int) -> String {
        if timePart < 10 {
            return "0" + String(timePart)
        }
        else {
            return String(timePart)
        }
    }
    
    private func showTimer() {
        
        if isRecipeActive {
            timerConstraint.constant = 3
        }
        else {
            timerConstraint.constant = -72
        }
        
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
    }
    //----------------------------------------------------------------------------
    
    private func configureTitleCell(cell:RecipeTitleTableViewCell) -> RecipeTitleTableViewCell {
        guard let recipe = recipe else { return cell}
        cell.titleRecLable.text = recipe.title
        if isRecipeActive {
            cell.letCookButton.setTitle("Прекратить готовить", for: .normal)
        }
        else {
            cell.letCookButton.setTitle("Приготовить", for: .normal)
        }
        showTimer()
        return cell
    }
    
    @IBAction func activateRecButton(_ sender: Any) {
        if isRecipeActive {
            isRecipeActive = false
        }
        else {
            isRecipeActive = true
        }
        recipeTable.reloadData()
    }
    
    private func configureIngridCell(with indexPath:Int, cell:IngridientsTableViewCell) -> IngridientsTableViewCell {
        var count = 0
        var text: String = ""
        for ingrid in ingridiends {
            count += 1
            text = text + String(count) + ") " + cell.ingridientsText.text + ingrid.title + "\n"
            
            if let quantity = ingrid.quantity {
                
                text = text + quantity + "\n"
            }
        }
        cell.ingridientsText.text = text
        
        return cell
    }
    
    private func configurePartCell(with indexPathRow:Int, cell:RecipeTableViewCell) -> RecipeTableViewCell {
        
        // смещение массива этапов относительно прототипов ячейки
        let offset = indexPathRow - 3
        
        cell.titleLableCell.text = "Этап " + String(steps[offset].number)
        
        let recipeStepText = steps[offset].text
        let recipeStepImage = steps[offset].img
        let recipeStepTime = steps[offset].time
        
        if let stepImage = recipeStepImage {
            delegatWorkWithAlomofire.downloadImage(url: stepImage) { (image) in
                DispatchQueue.main.async {
                    cell.imageViewCell.image = image
                }
            }
        }
        else {
            cell.imageHConstraint.constant = 0
        }
        
        if let stepTimer = recipeStepTime {
            cell.beginStopButton.isEnabled = true
            cell.timerLable.text = timerConstructor(initSeconds: stepTimer)
            cell.beginStopButton.tag = stepTimer
        }
        else {
            cell.timerLable.isHidden = true
            cell.beginStopButton.isHidden = true
        }
        
        if isRecipeActive == false {
            cell.beginStopButton.isEnabled = false
        }
        
        cell.beginStopButton.addTarget(self, action: #selector(initTimer(sender:)), for: .touchUpInside)
        
        cell.recipetLableCell.text = recipeStepText
        
        return cell
    }
    
    private func configureImageCell(cell:ImageRecipeTableViewCell) -> ImageRecipeTableViewCell {
        guard let recipe = recipe else { return cell }
        cell.imageViewCell.image = UIImage(named: "noPhoto")
        delegatWorkWithAlomofire.downloadImage(url: recipe.url) { (image) in
            DispatchQueue.main.async {
                cell.imageViewCell.image = image
            }
        }
        return cell
    }
    
    @IBAction func doneButton(_ sender: Any) {
        timer.invalidate()
        timeInSeconds = 0
        isTimerActive = false
    }
    
    @IBAction func pauseButton(_ sender: Any) {
        if resumeTapped == false {
            timer.invalidate()
            resumeTapped = true
        } else {
            runTimer()
            resumeTapped = false
        }
    }
}

// MARK: - Table view data source
extension RecipeMainConrollerTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3 + steps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // демонстрация ячеек
        
        let titleCell = tableView.dequeueReusableCell(withIdentifier: "recipeTitleCell", for: indexPath) as! RecipeTitleTableViewCell
        
        let imageCell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as! ImageRecipeTableViewCell
        
        let ingridientsCell = tableView.dequeueReusableCell(withIdentifier: "IngridientsCell", for: indexPath) as! IngridientsTableViewCell
        
        let recipeCell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeTableViewCell
        
        switch indexPath.row {
        case 0:
            return configureTitleCell(cell: titleCell)
        case 1:
            return configureImageCell(cell: imageCell)
        case 2:
            return configureIngridCell(with: indexPath.row, cell: ingridientsCell)
        case 3...:
            return configurePartCell(with: indexPath.row, cell: recipeCell)
        default:
            print("error")
        }
        return titleCell
    }
}
