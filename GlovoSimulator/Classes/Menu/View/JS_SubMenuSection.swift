//
//  JS_SubMenuSection.swift
//  GlovoSimulator
//
//  Created by JS_Coder on 11/8/18.
//  Copyright © 2018 JS_Coder. All rights reserved.
//

import UIKit

class JS_SubMenuSection: UIView {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    @IBOutlet weak var requiredLabel: UILabel!
    static func initWithNib() -> JS_SubMenuSection{
        return Bundle.main.loadNibNamed("JS_SubMenuSection", owner: nil, options: nil)?.first as! JS_SubMenuSection
    }
    
    
    
}
