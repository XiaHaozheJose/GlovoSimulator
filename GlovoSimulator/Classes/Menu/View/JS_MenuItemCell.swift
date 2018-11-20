//
//  JS_MenuItemCell.swift
//  GlovoSimulator
//
//  Created by JS_Coder on 11/7/18.
//  Copyright © 2018 JS_Coder. All rights reserved.
//

import UIKit

@objc protocol MenuItemDelagate {
    func menuItemAddItem(cell: JS_MenuItemCell)
}

class JS_MenuItemCell: UITableViewCell {
    
    weak var delegate: MenuItemDelagate?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    var model: JS_MenuModel?{
        didSet{
            descriptionLabel.text = model?.descriptionMenu
            titleLabel.text = model?.title
            priceLabel.text = model?.price
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @IBAction func addMenu(_ sender: UIButton) {
        delegate?.menuItemAddItem(cell: self)
    }
    
}
