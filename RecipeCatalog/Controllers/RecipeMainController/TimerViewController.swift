//
//  TimerViewController.swift
//  RecipeCatalog
//
//  Created by Артем Чурсин on 24/11/2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import UIKit

class TimerViewController: UIViewController {

    //MARK: - Constants
    private let date = Date()
    private let calendar = Calendar.current
    
    //MARK: - Variables
    var time = 110 //------------
    var step = "Step..."
    private var timer = Timer()
    
//    var recipeViewController: RecipeMainConrollerTableViewController?
    
    
    //MARK: - Outlets
    @IBOutlet weak var stepLable: UILabel!
    @IBOutlet weak var timerLable: UILabel!
    
    @IBOutlet weak var pauseButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var maskView: UIView!
    
    //MARK: - LifeStyle ViewController
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        let buttonRadius: CGFloat = 20
        
        doneButton.layer.cornerRadius = buttonRadius
        pauseButton.layer.cornerRadius = buttonRadius
        
        maskView.layer.cornerRadius = 30
        maskView.layer.shadowOpacity = 0.4
        maskView.layer.shadowRadius = 5
        maskView.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        cellSetup()
        
    }
    
    //MARK: - Navigation
    
//    func saveContrainerViewRefference(vc: RecipeMainConrollerTableViewController){
//
//        self.recipeViewController = vc
//    }
    
    //MARK: - Private methods
    private func cellSetup() {
        
        backgroundView.backgroundColor = ThemAppearance.backgroundColor.uiColor()
        maskView.backgroundColor = ThemAppearance.backgroundCellColor.uiColor()
        
        stepLable.textColor = ThemAppearance.textColor.uiColor()
        timerLable.textColor = ThemAppearance.textColor.uiColor()
    }
    
    @objc private func timerSetting() {
        
        var hours = 0
        var minuts = 0
        var seconds = 0
        var tmp = 0
        
        if time > 0 {
            
            time -= 1
            seconds = time % 60
            tmp = time / 60
            minuts = tmp % 60
            hours = tmp / 60
            
            let timerText = toStringTimer(hours) + ":" + toStringTimer(minuts) + ":" + toStringTimer(seconds)
            
//            let secondsDate = calendar.component(.minute, from: date)
//            print(secondsDate)
            timerLable.text = timerText
        }
    }
    
    private func toStringTimer(_ timePart: Int) -> String {
        if timePart < 10 {
            return "0" + String(timePart)
        }
        else {
            return String(timePart)
        }
    }
    
    @IBAction func doneAction(_ sender: Any) {
        
        stepLable.text = step
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TimerViewController.timerSetting), userInfo: nil, repeats: true)
    }
    
    @IBAction func pauseAction(_ sender: Any) {
        
    }
    
}
