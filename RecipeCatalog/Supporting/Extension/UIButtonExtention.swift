//
//  UIButtonExtention.swift
//  flyButton
//
//  Created by Артем Чурсин on 13/11/2018.
//  Copyright © 2018 Artem Chursin. All rights reserved.
//

import UIKit

extension UIButton {
    
    func createFloatingActionButton() {
        
        backgroundColor = ThemAppearance.backgroundButtonColor.uiColor()
        layer.cornerRadius = frame.width / 2
        layer.shadowOpacity = 0.25
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 10)
    }
}
