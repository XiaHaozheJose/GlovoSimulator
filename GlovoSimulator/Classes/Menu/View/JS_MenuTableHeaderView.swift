//
//  JS_MenuTableHeaderView.swift
//  GlovoSimulator
//
//  Created by JS_Coder on 11/7/18.
//  Copyright © 2018 JS_Coder. All rights reserved.
//

import UIKit

class JS_MenuTableHeaderView: UIView {

    @IBOutlet weak var contentView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.alpha = 0.9
    }
    
    static func loadViewWithNib()->JS_MenuTableHeaderView{
      return Bundle.main.loadNibNamed("JS_MenuTableHeaderView", owner: nil, options: nil)?.first as! JS_MenuTableHeaderView
    }
    
}
