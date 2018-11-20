//
//  JS_SubMenuController.swift
//  GlovoSimulator
//
//  Created by JS_Coder on 11/7/18.
//  Copyright © 2018 JS_Coder. All rights reserved.
//

import UIKit

@objc protocol SubMenuDelegate{
    func subMenuFinished(content: String)
}

class JS_SubMenuController: UIViewController {
    
    let subMenuCellIdentifier = "subMenuCellIdentifier"
    
    let buttonMargin: CGFloat = 15
    let headerViewHeight: CGFloat = 180
    
    var subMenuModels: [JS_SubMenuModel]?{
        didSet{
            tableView.reloadData()
        }
    }
    
    weak var delegate: SubMenuDelegate?
    var selectedSingle: [String:IndexPath] = [:] {
        didSet{
            if selectedSingle.count > 0 , selectedNonSingle.count > 0{
                doneButton.backgroundColor = UIColor.init(hexString: "#40E0D0")
                doneButton.isEnabled = true
            }else{
                doneButton.backgroundColor = .lightGray
                doneButton.isEnabled = false
            }
        }
    }
    var selectedNonSingle: [String: IndexPath] = [:] {
        didSet{
            if selectedNonSingle.count > 0 , selectedSingle.count > 0{
                doneButton.backgroundColor = UIColor.init(hexString: "#40E0D0")
                doneButton.isEnabled = true
            }else {
                doneButton.backgroundColor = .lightGray
                doneButton.isEnabled = false
            }
        }
    }
    /// 列表
    lazy var tableView: UITableView = {
        let t = UITableView(frame: self.view.bounds, style: .grouped)
        t.backgroundColor = .white
        t.estimatedRowHeight = 44
        t.rowHeight = UITableView.automaticDimension
        t.separatorStyle = .none
        t.register(UINib(nibName: "JS_SubMenuCell", bundle: nil), forCellReuseIdentifier: subMenuCellIdentifier)
        t.delegate = self
        t.dataSource = self
        return t
    }()
    
    lazy var headerView: UIView = {
        let v = UIView(frame: CGRect(x: 30, y: 0, width: kScreenWidth - 60, height: headerViewHeight))
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.text = "Customise Your Crea tu combinacion"
        label.font = UIFont.systemFont(ofSize: 20, weight:.semibold)
        label.sizeToFit()
        label.center = v.center
        v.addSubview(label)
        return  v
    }()
    
    // 底部按钮
    lazy var doneButton: UIButton = {
        let done = UIButton()
        done.frame = CGRect(x: buttonMargin, y: kScreenHeight - buttonMargin - 44, width: kScreenWidth - buttonMargin * 2, height: 44)
        done.layer.cornerRadius = 22
        done.layer.masksToBounds = true
        done.backgroundColor = .lightGray
        done.isEnabled = false
        done.setTitleColor(.white, for: .normal)
        done.setTitleColor(.gray, for: .highlighted)
        done.setTitle("Done", for: .normal)
        done.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        done.addTarget(self, action: #selector(doneButtonClicked), for: .touchUpInside)
        return done
    }()
    
    lazy var dimissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "dissmisImage"), for: .normal)
        button.sizeToFit()
        button.frame.origin = CGPoint(x: buttonMargin, y: buttonMargin * 2)
        button.addTarget(self, action: #selector(dismissButtonClicked), for: .touchUpInside)
        return button
    }()
    
    //MARK: - CycleLife
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setDatas()
    }
    
    
    @objc private func doneButtonClicked(){
        var content = ""
        for (_, dict) in selectedSingle.enumerated(){
            let index = dict.value
            if let model = subMenuModels?[index.section].subContentModels?[index.row]{
                content += model.name + ","
            }
        }
        for(_,dict) in selectedNonSingle.enumerated(){
            let index = dict.value
            if let model = subMenuModels?[index.section].subContentModels?[index.row]{
                content += model.name + ","
            }
        }
        delegate?.subMenuFinished(content: content)
        globalSelectedSingle = selectedSingle
        globalSelectedNonSingle = selectedSingle
        dismissButtonClicked()
    }
    
    @objc private func dismissButtonClicked(){
        self.dismiss(animated: true, completion: nil)
    }
    
    
}


// MARK: - SETDATAS
extension JS_SubMenuController{
    private func config(){
        view.backgroundColor = .white
        setUI()
    }
    
    // 添加控件
    private func setUI(){
        view.addSubview(tableView)
        view.addSubview(doneButton)
        view.addSubview(dimissButton)
        tableView.tableHeaderView = headerView
    }
    
    // 获取数据
    private func setDatas(){
        var models: [JS_SubMenuModel] = []
        for item in subMenuDatas{
            let subModel = JS_SubMenuModel(dict: item)
            models.append(subModel)
        }
        subMenuModels = models
    }
    
}

// MARK: - UITableViewDelegate,UITableViewDataSource
extension JS_SubMenuController: UITableViewDelegate,UITableViewDataSource,SubmenuCellDelegate{
    func subMenuCellDidSelected(cell: JS_SubMenuCell, isSingle: Bool, sender: UIButton) {
        guard let index = tableView.indexPath(for: cell) else {return}
        guard let model = subMenuModels?[index.section].subContentModels?[index.row]else{return}
        if isSingle{
            if let selectIndex = selectedSingle["\(index.section)"], selectIndex.section == index.section {
                if selectIndex.row == index.row{
                    selectedSingle.removeValue(forKey: "\(index.section)")
                    model.isSelected = false
                }else{
                    let preIndex = selectedSingle["\(index.section)"]
                    guard let preModel = subMenuModels?[preIndex!.section].subContentModels?[preIndex!.row]else{return}
                    preModel.isSelected = false
                    selectedSingle.removeValue(forKey: "\(preIndex!.section)")
                    model.isSelected = true
                    selectedSingle["\(index.section)"] = index
                }
            }else{
                selectedSingle["\(index.section)"] = index
                model.isSelected = true
            }
        }else{
            if selectedNonSingle["\(index.section)_\(index.row)"] == index{
                selectedNonSingle.removeValue(forKey: "\(index.section)_\(index.row)")
                model.isSelected = false
            }else{
                selectedNonSingle["\(index.section)_\(index.row)"] = index
                model.isSelected = true
            }
        }
        tableView.reloadSections(IndexSet.init(integer: index.section), with: UITableView.RowAnimation.none)

        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return subMenuModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subMenuModels?[section].subContentModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: subMenuCellIdentifier, for: indexPath) as! JS_SubMenuCell
        cell.delegate = self
        cell.selectionStyle = .none
        if let model = subMenuModels?[indexPath.section].subContentModels?[indexPath.row]{
            cell.isSingleSelect = subMenuModels![indexPath.section].isSingleSelected
            cell.subContentModel = model
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = JS_SubMenuSection.initWithNib()
        if let model = subMenuModels?[section]{
            v.title.text = model.title
            if model.isRequied == true{
                v.requiredLabel.isHidden = false
            }else{
                v.requiredLabel.isHidden = true
            }
        }
        return v
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64
    }
    
}
