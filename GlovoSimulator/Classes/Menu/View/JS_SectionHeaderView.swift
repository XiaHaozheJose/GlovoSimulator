//
//  JS_SectionHeaderView.swift
//  GlovoSimulator
//
//  Created by JS_Coder on 11/7/18.
//  Copyright © 2018 JS_Coder. All rights reserved.
//

import UIKit

class JS_SectionHeaderView: UIView {

    let label = UILabel()
    var sectionTitle: String? {
        didSet{
           label.text = sectionTitle
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        label.text = "TOP VENTAS"
        label.font = UIFont.systemFont(ofSize: 18, weight: .black)
        label.frame = self.frame
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    

}
