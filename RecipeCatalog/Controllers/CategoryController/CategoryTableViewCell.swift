//
//  CategoryTableViewCell.swift
//  RecipeCatalog
//
//  Created by Артем Чурсин on 31/10/2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var backgroundCellMask: UIView!
    @IBOutlet weak var imageCell: UIImageView!
    @IBOutlet weak var contentViewCell: UIView!
    @IBOutlet weak var labelCell: UILabel!
    
    //MARK: - CellConfig
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cellBuilder()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let radius: CGFloat = 42
        
        backgroundCellMask.layer.cornerRadius = radius
        
        imageCell.layer.masksToBounds = true
        imageCell.layer.cornerRadius = radius
        
        backgroundCellMask.layer.shadowOpacity = 0.4
        backgroundCellMask.layer.shadowRadius = 5
        backgroundCellMask.layer.shadowOffset = CGSize(width: 0, height: 4)

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    //MARK: - Methods
    func cellBuilder() {
        
//        contentViewCell.backgroundColor = UIColor.backgroundColor
        contentViewCell.backgroundColor = ThemAppearance.backgroundColor.uiColor()
    }
}
