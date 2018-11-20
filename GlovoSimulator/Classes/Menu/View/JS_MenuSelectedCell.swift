//
//  JS_MenuSelectedCell.swift
//  GlovoSimulator
//
//  Created by JS_Coder on 11/8/18.
//  Copyright © 2018 JS_Coder. All rights reserved.
//

import UIKit

class JS_MenuSelectedCell: UITableViewCell {

    @IBOutlet weak var menuTitleLabel: UILabel!
    @IBOutlet weak var contentMenu: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func plusButtonClicked(_ sender: Any) {
        
    }
    
    
    @IBAction func minusButtonClicked(_ sender: Any) {
        
    }
}
