//
//  JS_HomeContentCell.swift
//  GlovoSimulator
//
//  Created by JS_Coder on 11/6/18.
//  Copyright © 2018 JS_Coder. All rights reserved.
//

import UIKit

class JS_HomeContentCell: UITableViewCell {
    
    
    @IBOutlet weak var contentImageView: UIImageView!
    @IBOutlet weak var contentTitle: UILabel!
    @IBOutlet weak var contentSubTitle: UILabel!
    @IBOutlet weak var contentPrice: UIButton!
    @IBOutlet weak var contentDuration: UILabel!
    var resModel: JS_RestauranteModel?{
        didSet{
            setData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        contentImageView.layer.cornerRadius = 10
        contentImageView.layer.masksToBounds = true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    private func setData(){
        if let model = resModel{
            if let image = UIImage(named: model.image){
                contentImageView.image = image
            }
        }
    }
    
}
