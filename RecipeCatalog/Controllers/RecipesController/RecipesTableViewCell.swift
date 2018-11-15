//
//  RecipesTableViewCell.swift
//  RecipeCatalog
//
//  Created by Артем Чурсин on 31/10/2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import UIKit

class RecipesTableViewCell: UITableViewCell {

    
    //MARK: - Outlets
    
    @IBOutlet weak var contentCell: UIView!
    @IBOutlet weak var maskViewCell: UIView!
    @IBOutlet weak var imageViewCell: UIImageView!
    @IBOutlet weak var recipeNameCell: UILabel!
    @IBOutlet weak var ingredientsNamesCell: UILabel!
    @IBOutlet weak var complexity: UILabel!
    
    @IBOutlet weak var beer1: UIImageView!
    @IBOutlet weak var beer2: UIImageView!
    @IBOutlet weak var beer3: UIImageView!
    @IBOutlet weak var beer4: UIImageView!
    @IBOutlet weak var beer5: UIImageView!
    
    
    //MARK: - CellConfig
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellBuilder()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let radius: CGFloat = 42
        
        maskViewCell.layer.cornerRadius = radius
        
        imageViewCell.layer.masksToBounds = true
        imageViewCell.layer.cornerRadius = radius
        
        maskViewCell.layer.shadowOpacity = 0.4
        maskViewCell.layer.shadowRadius = 5
        maskViewCell.layer.shadowOffset = CGSize(width: 0, height: 4)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    
    //MARK: - Methods
    
    func cellBuilder() {
        
        contentCell.backgroundColor = ThemAppearance.backgroundColor.uiColor()
        maskViewCell.backgroundColor = ThemAppearance.backgroundCellColor.uiColor()
//        contentCell.backgroundColor = UIColor.backgroundColor
//        maskViewCell.backgroundColor = UIColor.backgroundCellColor
    }
}
