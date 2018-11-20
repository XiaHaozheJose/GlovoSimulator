//
//  JS_RestauranteModel.swift
//  GlovoSimulator
//
//  Created by JS_Coder on 11/7/18.
//  Copyright © 2018 JS_Coder. All rights reserved.
//

import UIKit

class JS_RestauranteModel: NSObject {

    @objc var image: String = ""
    @objc var tag: [String]?
    
    init(image: String, tag: [String]) {
        self.image = image
        self.tag = tag
    }
}
