//
//  JS_MenuViewController.swift
//  GlovoSimulator
//
//  Created by JS_Coder on 11/7/18.
//  Copyright © 2018 JS_Coder. All rights reserved.
//

import UIKit
import SnapKit


class JS_MenuViewController: UIViewController {
    
    let origenHeight: CGFloat = 180
    let origenHeaderY: CGFloat = 180 - 64
    let oriOffsetY: CGFloat = -244
    let topBarHeight: CGFloat = 64
    var indexSelected: IndexPath?
    
    @IBOutlet weak var heightImageConstraint: NSLayoutConstraint!
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var menuTableView: UITableView!
    let menuItemIdentifier = "menuItemIdentifier"
    let menuSelectedIdentifier = "menuSelectedIdentifier"
    
    var menuModels: [JS_MenuModel]?{
        didSet{
            menuTableView.reloadData()
        }
    }
    var sectionCount: [Int] = [0,0,0,0]
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    var image: UIImage!
    
    lazy var topBar: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 10, width: kScreenWidth, height: topBarHeight))
        v.backgroundColor = .clear
        return v
    }()
    
    lazy var baseTopView: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 10, width: kScreenWidth, height: topBarHeight))
        v.backgroundColor = .clear
        return v
    }()
    
    lazy var dissmisButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 15, y: 10, width: 44, height: 44))
        button.setImage(UIImage(named: "back"), for: .normal)
        button.addTarget(self, action: #selector(dissmissToHome), for: .touchUpInside)
        return button
    }()
    
    lazy var searchBar: UISearchBar = {
        let bar = UISearchBar(frame: CGRect(x: dissmisButton.frame.maxX, y: 10, width: kScreenWidth - dissmisButton.frame.maxX - 10, height: 44))
        bar.setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        bar.isTranslucent = true
        bar.placeholder = "Search in Subway"
        bar.delegate = self
        return bar
    }()
    
    lazy var headerView: JS_MenuTableHeaderView = {
        let v = JS_MenuTableHeaderView.loadViewWithNib()
        v.frame = CGRect(x: 0, y: menuImageView.frame.maxY - 64, width: kScreenWidth, height: 128)
        v.backgroundColor = .clear
        return v
    }()
    
    // MARK: - CycleLife
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            menuTableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false;
        };
        // Do any additional setup after loading the view.
        configTableView()
        view.addSubview(headerView)
        view.addSubview(topBar)
        view.addSubview(baseTopView)
        setTopBarAnimation()
        initialMenuDatas()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        menuImageView.image = image
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    
    @objc private func dissmissToHome(){
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        // 删除键盘监听
        NotificationCenter.default.removeObserver(self)
    }
    
}


// MARK: - SetUI/ DATA
extension JS_MenuViewController{
    private func configTableView(){
        menuTableView.register(UINib(nibName: "JS_MenuItemCell", bundle: nil), forCellReuseIdentifier: menuItemIdentifier)
        menuTableView.register(UINib(nibName: "JS_MenuSelectedCell", bundle: nil), forCellReuseIdentifier: menuSelectedIdentifier)
        menuTableView.estimatedRowHeight = 100
        menuTableView.rowHeight = UITableView.automaticDimension
        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.contentInset = UIEdgeInsets(top: 244, left: 0, bottom: 0, right: 0)
    }
    
    private func configSearchBar(){
        let searchField = searchBar.value(forKey: "_searchField") as! UITextField
        searchField.textAlignment = .center
        searchField.layer.cornerRadius = 18
        searchField.layer.masksToBounds = true
    }
    
    // animation
    private func setTopBarAnimation(){
        UIView.animate(withDuration: 0.25, delay: 0.25, usingSpringWithDamping: 0.5, initialSpringVelocity: 20, options: .curveEaseInOut, animations: {
            self.baseTopView.addSubview(self.dissmisButton)
            self.baseTopView.addSubview(self.searchBar)
            self.configSearchBar()
        }, completion: nil)
    }
    // 初始化数据
    private func initialMenuDatas(){
        var models: [JS_MenuModel] = []
        for data in menuDatas{
            switch data["type"] as! Int {
            case 0:
                var count = sectionCount[0]
                count += 1
                sectionCount[0] = count
            case 1:
                var count = sectionCount[1]
                count += 1
                sectionCount[1] = count
            case 2:
                var count = sectionCount[2]
                count += 1
                sectionCount[2] = count
            case 3:
                var count = sectionCount[3]
                count += 1
                sectionCount[3] = count
            default:
                return
            }
            models.append(JS_MenuModel(dict: data))
        }
        print(sectionCount)
        menuModels = models
    }
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension JS_MenuViewController: UITableViewDelegate, UITableViewDataSource, MenuItemDelagate,SubMenuDelegate{
    //  cell数量
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionCount[section]
    }

    //cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: menuItemIdentifier, for: indexPath) as! JS_MenuItemCell
//        let subCell = tableView.dequeueReusableCell(withIdentifier: menuSelectedIdentifier, for: indexPath) as! JS_MenuSelectedCell
       
        if let model = menuModels?[indexPath.row] {
            cell.delegate = self
            cell.model = model
        }
        return cell
    }
    
    // section数量
    func numberOfSections(in tableView: UITableView) -> Int {
        return types.count
    }
    // 头部sectiongaodu
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        if section == 0 { label.textColor = .orange}else{ label.textColor = .black}
        label.text = types[section]
        label.font = UIFont.systemFont(ofSize: 18, weight: .black)
        label.sizeToFit()
        return label
    }
    // 滑动监听
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsety = scrollView.contentOffset.y - oriOffsetY
        var imageH = origenHeight - offsety
        
        var scale = imageH / origenHeight
        if scale >= 1 {
            scale = 1
        }else if scale <= 0.5 {
            scale = 0.5
        }
        let headrY = origenHeaderY - offsety
        headerView.frame.origin.y = headrY
        headerView.transform = CGAffineTransform.init(scaleX: scale, y: scale)
        if imageH <= topBarHeight {
            imageH = topBarHeight
        }
        heightImageConstraint.constant = imageH
    }
    // 点击添加menu按钮
    func menuItemAddItem(cell: JS_MenuItemCell) {
        guard let index = menuTableView.indexPath(for: cell) else {return}
        if let model = menuModels {
            if model[index.row].isSubMenu == 1{
                let subMenuVC = JS_SubMenuController()
                subMenuVC.view.frame = self.view.bounds
                subMenuVC.delegate = self
                self.present(subMenuVC, animated: true) {
                    self.indexSelected = index
                }
            }else{
                
            }
        }
    }
    //结束选项回调
    func subMenuFinished(content: String) {
        if let index = indexSelected, let model = menuModels?[index.row]{
            menuModels?.insert(JS_MenuModel(dict: ["title": model.title,
                                                   "price": model.price,
                                                   "descriptionMenu": content,
                                                   "isSubMenu": 0]), at: index.row)
//            menuTableView.insertRows(at: [index], with: UITableView.RowAnimation.fade)
//            menuTableView.cellForRow(at: index)?.backgroundColor = .lightGray
            menuTableView.reloadData()
        }
    }
}

// MARK: - 监听
extension JS_MenuViewController: UISearchBarDelegate{
    @objc func keyBoardWillShow(notification: Notification) {
        let userInfo = notification.userInfo! as Dictionary
        let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let keyBoardRect = value.cgRectValue
        // 得到键盘高度
//        let keyBoardHeight = keyBoardRect.size.height
        // 得到键盘弹出所需时间
//        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber
        
    }
    // MARK: - 键盘即将回收
    @objc func keyBoardWillHide(notification: Notification) {
        let userInfo = notification.userInfo! as Dictionary
        let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        let keyBoardRect = value.cgRectValue
        // 得到键盘高度
//        let keyBoardHeight = keyBoardRect.size.height
        // 得到键盘弹出所需时间
//        let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as! NSNumber
    }
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = true
        let cancelButton = searchBar.value(forKey: "cancelButton") as! UIButton
        cancelButton.setTitleColor(.white, for: .normal)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsCancelButton = false
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}



