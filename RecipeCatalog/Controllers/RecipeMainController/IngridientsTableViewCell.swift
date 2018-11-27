//
//  IngridientsTableViewCell.swift
//  RecipeCatalog
//
//  Created by Артем Чурсин on 07/11/2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import UIKit

class IngridientsTableViewCell: UITableViewCell {
    @IBOutlet weak var contentCell: UIView!
    @IBOutlet weak var maskViewCell: UIView!
    @IBOutlet weak var titleLableCell: UILabel!
    @IBOutlet weak var lineViewCell: UIView!
    @IBOutlet weak var addToBasketButtonCell: UIButton!
    
    @IBOutlet weak var ingridientsText: UITextView!
    @IBOutlet weak var ingridientsPartsText: UITextView!
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let radius: CGFloat = 42
        let buttonRadius: CGFloat = 20
        
        maskViewCell.layer.cornerRadius = radius
        addToBasketButtonCell.layer.cornerRadius = buttonRadius
        
        maskViewCell.layer.shadowOpacity = 0.4
        maskViewCell.layer.shadowRadius = 5
        maskViewCell.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellBuilder()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK: - Methods
    func cellBuilder() {

        contentCell.backgroundColor = ThemAppearance.backgroundColor.uiColor()
        maskViewCell.backgroundColor = ThemAppearance.backgroundCellColor.uiColor()
        lineViewCell.backgroundColor = ThemAppearance.textColor.uiColor()
        addToBasketButtonCell.backgroundColor = ThemAppearance.backgroundButtonColor.uiColor()
        
        ingridientsText.isEditable = false
        ingridientsText.textColor = ThemAppearance.textColor.uiColor()
        ingridientsText.backgroundColor = ThemAppearance.backgroundCellColor.uiColor()
        
        ingridientsPartsText.isEditable = false
        ingridientsPartsText.textColor = ThemAppearance.textColor.uiColor()
        ingridientsPartsText.backgroundColor = ThemAppearance.backgroundCellColor.uiColor()
        
        titleLableCell.textColor = ThemAppearance.textColor.uiColor()
    }

}
