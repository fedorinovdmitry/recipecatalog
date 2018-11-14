//
//  ThemsViewController.swift
//  RecipeCatalog
//
//  Created by Артем Чурсин on 14/11/2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import UIKit

class ThemsViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var lightImage: UIImageView!
    @IBOutlet weak var heightLightImage: NSLayoutConstraint!
    @IBOutlet weak var widthLightImage: NSLayoutConstraint!
    
    @IBOutlet weak var darkImadge: UIImageView!
    @IBOutlet weak var heightDarkImadge: NSLayoutConstraint!
    @IBOutlet weak var weightDarkImadge: NSLayoutConstraint!
    
    @IBOutlet weak var welcomaLable: UILabel!
    @IBOutlet weak var chooseLable: UILabel!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var applyButton: UIButton!
    
    //MARK: - LifeStyle ViewController
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        applyButton.layer.cornerRadius = 20
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //временный мусор
        let backgroundColor = UIColor(hexString: "#95C595")
        let backgroundButtonColor = UIColor(hexString: "#67A967")
        let themTextColor = UIColor.black
        
        backgroundView.backgroundColor = backgroundColor
        applyButton.backgroundColor = backgroundButtonColor
        applyButton.tintColor = themTextColor
        welcomaLable.textColor = themTextColor
        chooseLable.textColor = themTextColor
        
        applyButton.isEnabled = false
    }
    
    //MARK: - Methods
    
    @IBAction func handleTap(_ sender: Any) {
        
        if heightLightImage.constant < 350 && heightDarkImadge.constant < 350
        {
            heightLightImage.constant = heightLightImage.constant * 1.5
            widthLightImage.constant = widthLightImage.constant * 1.5
            
            lightImage.layer.zPosition = 2
            darkImadge.layer.zPosition = 1
            
            makeLightInterface()
            applyButton.isEnabled = true
        }
        else if heightLightImage.constant < 350 && heightDarkImadge.constant > 350{
            heightLightImage.constant = heightLightImage.constant * 1.5
            widthLightImage.constant = widthLightImage.constant * 1.5
            
            heightDarkImadge.constant = 348.0
            weightDarkImadge.constant = 160.7
            
            lightImage.layer.zPosition = 2
            darkImadge.layer.zPosition = 1
            
            makeLightInterface()
            applyButton.isEnabled = true
        }
        
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
    }
    
    @IBAction func handelDarkTap(_ sender: Any) {
        if heightLightImage.constant < 350 && heightDarkImadge.constant < 350
        {
            heightDarkImadge.constant = heightDarkImadge.constant * 1.5
            weightDarkImadge.constant = weightDarkImadge.constant * 1.5
            
            darkImadge.layer.zPosition = 2
            lightImage.layer.zPosition = 1
            
            makeDarkInterface()
            applyButton.isEnabled = true
        }
        else if heightLightImage.constant > 350 && heightDarkImadge.constant < 350{
            heightDarkImadge.constant = heightDarkImadge.constant * 1.5
            weightDarkImadge.constant = weightDarkImadge.constant * 1.5
            
            heightLightImage.constant = 348.0
            widthLightImage.constant = 160.7
            
            darkImadge.layer.zPosition = 2
            lightImage.layer.zPosition = 1
            
            makeDarkInterface()
            applyButton.isEnabled = true
        }
        
        UIView.animate(withDuration: 0.3){
            self.view.layoutIfNeeded()
        }
    }
    
    // Заглушка
    private func makeDarkInterface() {

        //временный мусор
        let backgroundColor = UIColor(hexString: "#2E3032")
        let backgroundButtonColor = UIColor(hexString: "#616569")
        let themTextColor = UIColor(hexString: "#C3C3C3")
        
        backgroundView.backgroundColor = backgroundColor
        applyButton.backgroundColor = backgroundButtonColor
        applyButton.tintColor = themTextColor
        welcomaLable.textColor = themTextColor
        chooseLable.textColor = themTextColor
    }
    
    private func makeLightInterface() {
        //временный мусор
        let backgroundColor = UIColor(hexString: "#95C595")
        let backgroundButtonColor = UIColor(hexString: "#67A967")
        let themTextColor = UIColor.black
        
        backgroundView.backgroundColor = backgroundColor
        applyButton.backgroundColor = backgroundButtonColor
        applyButton.tintColor = themTextColor
        welcomaLable.textColor = themTextColor
        chooseLable.textColor = themTextColor
    }
}
