//
//  RecipeTitleTableViewCell.swift
//  RecipeCatalog
//
//  Created by Артем Чурсин on 20/11/2018.
//  Copyright © 2018 BezBab. All rights reserved.
//

import UIKit

class RecipeTitleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var letCookButton: UIButton!
    @IBOutlet weak var titleRecLable: UILabel!
    @IBOutlet weak var maskViewCell: UIView!
    @IBOutlet weak var contentCell: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let radius: CGFloat = 42
        let buttonRadius: CGFloat = 20
        
        maskViewCell.layer.cornerRadius = radius

        letCookButton.layer.cornerRadius = buttonRadius

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

        letCookButton.backgroundColor = ThemAppearance.backgroundButtonColor.uiColor()
        titleRecLable.textColor = ThemAppearance.textColor.uiColor()
    }

}
