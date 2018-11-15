//
//  ImageRecipeTableViewCell.swift
//  RecipeCatalog
//
//  Created by Артем Чурсин on 07/11/2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import UIKit

class ImageRecipeTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var imegeContentCell: UIView!
    @IBOutlet weak var maskViewCell: UIView!
    @IBOutlet weak var imageViewCell: UIImageView!
    
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBuilder()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK: - Methods
    func cellBuilder() {

        imegeContentCell.backgroundColor = ThemAppearance.backgroundColor.uiColor()
        maskViewCell.backgroundColor = ThemAppearance.backgroundCellColor.uiColor()
        
//        imegeContentCell.backgroundColor = UIColor.backgroundColor
//        maskViewCell.backgroundColor = UIColor.backgroundCellColor
    }
}
