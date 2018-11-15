//
//  ColorShame.swift
//  RecipeCatalog
//
//  Created by Артем Чурсин on 15/11/2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import Foundation
import UIKit

struct LightPalette {
    //    light
    static let backgroundColor = UIColor(hexString: "#95C595")
    static let backgroundCellColor = UIColor(hexString: "#7BDE7B")
    static let backgroundButtonColor = UIColor(hexString: "#67A967")
    static let backgroundNavigationColor = UIColor(hexString: "#8BE48B")
    static let textColor = UIColor.black
}
//    dark
struct DarkPalette{
    static let backgroundColor = UIColor(hexString: "#2E3032")
    static let backgroundCellColor = UIColor(hexString: "#45484B")
    static let backgroundButtonColor = UIColor(hexString: "#616569")
    static let backgroundNavigationColor = UIColor(hexString: "#3F4346")
    static let textColor = UIColor(hexString: "#C3C3C3")
}

struct SchemeColor {
    
    // MARK: - Properties
    private let dark: UIColor
    private let light: UIColor
    
    // MARK: - Initialization
    init(light: UIColor,
         dark: UIColor) {
        self.dark = dark
        self.light = light
    }
    
    // MARK: - Methods
    
    func uiColor() -> UIColor {
        var option: ColorSchemeOption
        let userDefoults = UserDefaults.standard
        
        let set = userDefoults.bool(forKey: "Them")
        print(set)
        if set == true{
            option = .LIGHT
            print("secondIFL")
        }
        else{
            print("secondIFD")
            option = .DARK
        }
        return colorWith(scheme: option)
    }
    
    func cgColor() -> CGColor {
        return UIColor().cgColor
    }
    
    // MARK: Private methods
    private func colorWith(scheme: ColorSchemeOption) -> UIColor {
        switch scheme {
        case .DARK:
            return dark
        case .LIGHT:
            return light
        }
    }
}


struct ThemAppearance {
    
    static let backgroundColor = SchemeColor(light: LightPalette.backgroundColor,
                                             dark: DarkPalette.backgroundColor)
    static let backgroundCellColor = SchemeColor(light: LightPalette.backgroundCellColor,
                                                 dark: DarkPalette.backgroundCellColor)
    static let backgroundButtonColor = SchemeColor(light: LightPalette.backgroundButtonColor,
                                                   dark: DarkPalette.backgroundButtonColor)
    static let backgroundNavigationColor = SchemeColor(light: LightPalette.backgroundNavigationColor,
                                                       dark: DarkPalette.backgroundNavigationColor)
    static let textColor = SchemeColor(light: LightPalette.textColor,
                                       dark: DarkPalette.textColor)
}

enum ColorSchemeOption {
    case DARK
    case LIGHT
}

//final class ColorScheme {
//
//    // MARK: - Properties
//    static let shared = ColorScheme()
//
//    var option: ColorSchemeOption
//    let userDefaults = UserDefaults.standard
//
//    let flag = false
//    // MARK: - Initialization
//    init() {
//        if let settings = userDefaults.string(forKey: "Them") {
//            print("firstIFL")
//            if settings == "Light"{
//                self.option = .LIGHT
//                print("secondIFL")
//            }
//            else{
//                print("secondIFD")
//                self.option = .DARK
//            }
//        }
//        else{
//            print("firstIFD")
//            self.option = .DARK
//        }
//    }
//}
