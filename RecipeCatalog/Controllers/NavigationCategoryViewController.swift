//
//  NavigationCategoryViewController.swift
//  RecipeCatalog
//
//  Created by Артем Чурсин on 07/11/2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import UIKit

class NavigationCategoryViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationBar.barTintColor = ThemAppearance.backgroundNavigationColor.uiColor()
        self.navigationBar.tintColor = UIColor.white
    }
}
