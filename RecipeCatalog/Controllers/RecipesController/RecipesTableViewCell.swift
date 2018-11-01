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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    //MARK: - Methods
    func cellBuilder() {
        
        contentCell.backgroundColor = UIColor.backgroundColor
        maskViewCell.backgroundColor = UIColor.backgroundCellColor
    }
}
