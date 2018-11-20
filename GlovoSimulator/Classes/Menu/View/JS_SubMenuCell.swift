//
//  JS_SubMenuCell.swift
//  GlovoSimulator
//
//  Created by JS_Coder on 11/7/18.
//  Copyright © 2018 JS_Coder. All rights reserved.
//

import UIKit

@objc protocol SubmenuCellDelegate {
    func subMenuCellDidSelected(cell: JS_SubMenuCell, isSingle: Bool, sender: UIButton)
}
class JS_SubMenuCell: UITableViewCell {

    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
  
    
    lazy var hub: UIView = {
        let v = UIView(frame: self.frame)
        v.alpha = 0.8
        v.backgroundColor = .black
        return v
    }()
    weak var delegate: SubmenuCellDelegate?
    var subContentModel: JS_SubMenuContentModel?{
        didSet{
            setDatas()
        }
    }
    var isSingleSelect: Bool!
    var addCount: Int = 0{
        didSet{
            countLabel.text = "\(addCount)"
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func selectButtonClicked(_ sender: UIButton) {
        delegate?.subMenuCellDidSelected(cell: self, isSingle: isSingleSelect, sender: selectButton)
    }
    @IBAction func plusButtonClicked(_ sender: UIButton) {
        addCount += 1
        if addCount >= 10 {
            addCount = 10
            plusButton.isEnabled = false
        }
    }
    @IBAction func minusButtonClicked(_ sender: UIButton) {
        addCount -= 1
        plusButton.isEnabled = true
        if addCount <= 0 {
            addCount = 0
        }
    }
    
    private func setDatas(){
        guard let model = subContentModel else {return}
        if isSingleSelect {
            selectButton.setImage(UIImage(named: "PAradioNotselected"), for: .normal)
            selectButton.setImage(UIImage(named: "PAradioSelected"), for: .selected)
            selectButton.setImage(UIImage(named: "PAradioNotselected"), for: .disabled)
        }else{
            selectButton.setImage(UIImage(named: "PAcheckboxNotSelected"), for: .normal)
            selectButton.setImage(UIImage(named: "PAcheckboxSelected"), for: .selected)
            selectButton.setImage(UIImage(named: "PAcheckboxDisabled"), for: .disabled)
        }
        selectButton.isSelected = model.isSelected
        nameLabel.text = model.name
        if model.price > 0 {
            priceLabel.text = " + \(model.price) E"
            priceLabel.isHidden = false
        }else {
            priceLabel.isHidden = true
        }
        
        if model.isBebida{
            plusButton.isHidden = false
            minusButton.isHidden = false
            countLabel.isHidden = false
        }else{
            plusButton.isHidden = true
            minusButton.isHidden = true
            countLabel.isHidden = true
        }
        countLabel.text = "\(addCount)"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        clearAllContent()
    }
    
    private func clearAllContent(){
        selectButton.isSelected = false
    }
}
