//
//  JS_FooterView.swift
//  GlovoSimulator
//
//  Created by JS_Coder on 11/7/18.
//  Copyright © 2018 JS_Coder. All rights reserved.
//

import UIKit

class JS_FooterView: UIView {

    
    //Button
    lazy var footerButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "tutorial01Gifts"), for: .normal)
        button.backgroundColor = UIColor.init(hexString: "#00FA9A")
        button.setTitle("CUSTOM GLOVO", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleColor(.black, for: .highlighted)
        button.frame.size = CGSize(width: self.frame.width - 20, height: 64)
        button.center = self.center
        button.layer.cornerRadius = 32
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        addCustomButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addCustomButton(){
        addSubview(footerButton)
    }
}
