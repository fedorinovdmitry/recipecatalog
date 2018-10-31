//
//  RecipesTableViewCell.swift
//  RecipeCatalog
//
//  Created by Артем Чурсин on 31/10/2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import UIKit

class RecipesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var contentCell: UIView!
    @IBOutlet weak var maskViewCell: UIView!
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var recipeNameCell: UILabel!
    @IBOutlet weak var ingredientsNamesCell: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        cellBuilder()
    }

    //построение интерфейса ячейки
    func cellBuilder() {
        
        let backgroundCellColor = hexStringToUIColor(hex: "#95C595")
        contentCell.backgroundColor = backgroundCellColor
        
        maskViewCell.layer.cornerRadius = 13
        maskViewCell.backgroundColor = hexStringToUIColor(hex: "#7BDE7B")
        
        imageViewCell.layer.masksToBounds = true
        imageViewCell.layer.cornerRadius = 42
        
    }
    
    //MARK: - Methods
    
    // Преобразование HEX цвета в UIColor
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
}
