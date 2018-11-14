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
        
        contentCell.backgroundColor = UIColor.backgroundColor
        maskViewCell.backgroundColor = UIColor.backgroundCellColor
        lineViewCell.backgroundColor = UIColor.themTextColor
        addToBasketButtonCell.backgroundColor = UIColor.backgroundButtonColor
        
        titleLableCell.textColor = UIColor.themTextColor
    }

}
