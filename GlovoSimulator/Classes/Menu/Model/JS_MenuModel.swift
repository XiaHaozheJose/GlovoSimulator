//
//  JS_MenuModel.swift
//  GlovoSimulator
//
//  Created by JS_Coder on 11/7/18.
//  Copyright © 2018 JS_Coder. All rights reserved.
//

import UIKit

class JS_MenuModel: NSObject {
    @objc var title: String = ""
    @objc var price: String = ""
    @objc var descriptionMenu: String = ""
    @objc var isSubMenu: Int = 0
    @objc var type: Int = 0
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
