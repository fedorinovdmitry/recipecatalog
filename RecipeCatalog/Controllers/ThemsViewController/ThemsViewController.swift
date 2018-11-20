//
//  ThemsViewController.swift
//  RecipeCatalog
//
//  Created by Артем Чурсин on 14/11/2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import UIKit

final class ThemsViewController: UIViewController {
    
    //MARK: - Constants
    let userDefaults = UserDefaults.standard
    
    //MARK: - Outlets
    @IBOutlet weak var lightImage: UIImageView!
    @IBOutlet weak var heightLightImage: NSLayoutConstraint!
    @IBOutlet weak var widthLightImage: NSLayoutConstraint!
    
    @IBOutlet weak var darkImadge: UIImageView!
    @IBOutlet weak var heightDarkImadge: NSLayoutConstraint!
    @IBOutlet weak var weightDarkImadge: NSLayoutConstraint!
    
    @IBOutlet weak var welcomaLable: UILabel!
    @IBOutlet weak var chooseLable: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var applyButton: UIButton!
    
    @IBOutlet weak var welcomeLableConstraint: NSLayoutConstraint!
    //MARK: - LifeStyle ViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeInterface()
        
        applyButton.isEnabled = false
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        applyButton.layer.cornerRadius = 20
    }
    
    //MARK: - Methods
    
    @IBAction func handleTap(_ sender: Any) {
        
        if heightLightImage.constant < 350 && heightDarkImadge.constant < 350 {
            
            startPosition(mainHeightConstraint: &heightLightImage.constant,
                          mainWeightConstraint: &widthLightImage.constant,
                          secondHeightConstraint: &heightDarkImadge.constant,
                          secondWeightConstraint: &weightDarkImadge.constant,
                          mainImadge: &lightImage.layer.zPosition,
                          secondImadge: &darkImadge.layer.zPosition, them: true)
        }
        else if heightLightImage.constant < 350 && heightDarkImadge.constant > 350 {
         
            afterPosition(mainHeightConstraint: &heightLightImage.constant,
                          mainWeightConstraint: &widthLightImage.constant,
                          secondHeightConstraint: &heightDarkImadge.constant,
                          secondWeightConstraint: &weightDarkImadge.constant,
                          mainImadge: &lightImage.layer.zPosition,
                          secondImadge: &darkImadge.layer.zPosition, them: true)
        }
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func handelDarkTap(_ sender: Any) {
       if heightLightImage.constant < 350 && heightDarkImadge.constant < 350 {
       
        startPosition(mainHeightConstraint: &heightDarkImadge.constant,
                      mainWeightConstraint: &weightDarkImadge.constant,
                      secondHeightConstraint: &heightLightImage.constant,
                      secondWeightConstraint: &widthLightImage.constant,
                      mainImadge: &darkImadge.layer.zPosition,
                      secondImadge: &lightImage.layer.zPosition, them: false)
            
        }
        else if heightLightImage.constant > 350 && heightDarkImadge.constant < 350 {
        afterPosition(mainHeightConstraint: &heightDarkImadge.constant,
                      mainWeightConstraint: &weightDarkImadge.constant,
                      secondHeightConstraint: &heightLightImage.constant,
                      secondWeightConstraint: &widthLightImage.constant,
                      mainImadge: &darkImadge.layer.zPosition,
                      secondImadge: &lightImage.layer.zPosition, them: false)
        }
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
    }
    
    //MARK: - Private methods
    private func startPosition(mainHeightConstraint: inout CGFloat,
                               mainWeightConstraint: inout CGFloat,
                               secondHeightConstraint: inout CGFloat,
                               secondWeightConstraint: inout CGFloat,
                               mainImadge: inout CGFloat,
                               secondImadge: inout CGFloat,
                               them: Bool) {
        
        mainHeightConstraint = mainHeightConstraint * 1.5
        mainWeightConstraint = mainWeightConstraint * 1.5
        
        secondHeightConstraint = secondHeightConstraint / 2
        secondWeightConstraint = secondWeightConstraint / 2
        
        mainImadge = 2
        secondImadge = 1
        
        userDefaults.set(them, forKey: "Them")
        makeInterface()
        welcomeLableConstraint.constant = welcomeLableConstraint.constant - 100
        applyButton.isEnabled = true
    }
    
    private func afterPosition(mainHeightConstraint: inout CGFloat,
                               mainWeightConstraint: inout CGFloat,
                               secondHeightConstraint: inout CGFloat,
                               secondWeightConstraint: inout CGFloat,
                               mainImadge: inout CGFloat,
                               secondImadge: inout CGFloat,
                               them: Bool) {
        
        mainHeightConstraint = 348.0 * 1.5
        mainWeightConstraint = 160.7 * 1.5
        
        secondHeightConstraint = 348.0 / 2
        secondWeightConstraint = 160.7 / 2
        
        mainImadge = 2
        secondImadge = 1
        
        userDefaults.set(them, forKey: "Them")
        
        makeInterface()
        applyButton.isEnabled = true
    }
    
    private func makeInterface() {
        backgroundView.backgroundColor = ThemAppearance.backgroundColor.uiColor()
        applyButton.backgroundColor = ThemAppearance.backgroundButtonColor.uiColor()
        applyButton.tintColor = ThemAppearance.textColor.uiColor()
        welcomaLable.textColor = ThemAppearance.textColor.uiColor()
        chooseLable.textColor = ThemAppearance.textColor.uiColor()
    }
}
