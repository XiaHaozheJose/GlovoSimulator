//
//  JS_SubMenuModel.swift
//  GlovoSimulator
//
//  Created by JS_Coder on 11/7/18.
//  Copyright © 2018 JS_Coder. All rights reserved.
//

import UIKit

class JS_SubMenuModel: NSObject {
    @objc var subContentModels: [JS_SubMenuContentModel]?
    @objc var title: String = ""
    @objc var isRequied: Bool = false
    @objc var isSingleSelected: Bool = false
    
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "subContent" {
            if let arr = value as? [Any]{
                var subContent: [JS_SubMenuContentModel] = []
                for item in arr{
                    subContent.append(JS_SubMenuContentModel(dict: item as! [String: Any]))
                }
                subContentModels = subContent
            }
        }
    }
}

@objc class JS_SubMenuContentModel: NSObject{
    @objc var name: String = ""
    @objc var price: Double = 0
    @objc var isBebida: Bool = false
    @objc var content: String = ""
    var isSelected: Bool = false 
    init(dict: [String: Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print(key)
    }
}
