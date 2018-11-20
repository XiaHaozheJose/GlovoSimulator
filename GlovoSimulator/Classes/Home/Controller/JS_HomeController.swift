//
//  JS_HomeViewController.swift
//  GlovoSimulator
//
//  Created by JS_Coder on 11/6/18.
//  Copyright © 2018 JS_Coder. All rights reserved.
//

import UIKit
import SnapKit
import Hero


let titleHeight: CGFloat = 64
let titleMargin: CGFloat = 15
let edgeMargin: CGFloat = 10
let origenOffssetY: CGFloat = 0
class JS_HomeController: UIViewController {
    
    var titleButtonWidth: CGFloat = 0
    var titleButtons: [UIButton] = []
    let titleButtonHeight = titleHeight
    let homeContentIdentifier = "homeContentIdentifier"
    var isFilter: Bool = false
    var selectedCell: JS_HomeContentCell!
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    var filterModels: [JS_RestauranteModel]?{
        didSet{
            
        }
    }
    
    @IBOutlet weak var topBaseView: UIView! // 顶部view
    @IBOutlet weak var contentTableView: UITableView! //tableView
    @IBOutlet weak var topConstraint: NSLayoutConstraint! //顶部约束
    
    // Models
    var resModels: [JS_RestauranteModel]?{
        didSet{
            contentTableView.reloadData()
        }
    }
    
    /// 以点击的button
    var selectedButton: UIButton?
    
    //FooterView
    lazy var footerView: JS_FooterView = {
        let foot = JS_FooterView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: 84))
        return foot
    }()
    
    /// 标题
    lazy var topTitleScrollView: UIScrollView = {
        let title = UIScrollView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: topBaseView.frame.height))
        title.backgroundColor = .clear
        title.showsHorizontalScrollIndicator = false
        title.bounces = false
        return title
    }()
    
    
    // MArK: - CycleLife
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image:UIImage(named: "scanQR")?.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(didClicked))
        self.title = "Glovo"
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "naviBarBackground"), for: .default)
        if #available(iOS 11.0, *) {
            contentTableView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false;
        };
        self.view.backgroundColor = UIColor.init(hexString: "#f3f2f2")
        self.view.hero.id = "skyWalker"
        setUI()
        setData()
    }
    @objc private func didClicked(){
        let scanVC = WHQRViewController()
        self.navigationController?.pushViewController(scanVC, animated: true)
    }
}

// MARK: - SetUI
extension JS_HomeController{
    private func setUI(){
        contentTableView.register(UINib(nibName: "JS_HomeContentCell", bundle: nil), forCellReuseIdentifier: homeContentIdentifier)
        contentTableView.rowHeight = 180
        contentTableView.tableFooterView = footerView
        contentTableView.delegate = self
        contentTableView.dataSource = self
        contentTableView.backgroundColor = .clear
        
        topBaseView.addSubview(topTitleScrollView)
        
        for (index,title) in dishes.enumerated() {
            setTitlesButtons(title: title, image:UIImage(named: "profile_faq")!, index: index)
        }
    }
    
    private func setData(){
        var models: [JS_RestauranteModel] = []
        for (key,value) in resDatas{
            let tags = value.components(separatedBy: "/")
            models.append(JS_RestauranteModel(image: key, tag: tags))
        }
        resModels = models
    }
    
    
    private func setTitlesButtons(title: String, image: UIImage, index: Int){
        if index == 0 {
            titleButtonWidth = titleMargin
        }
        let size = title.boundingRect(with: topTitleScrollView.frame.size, font: UIFont.systemFont(ofSize: 15))
        
        let button = UIButton()
        button.contentHorizontalAlignment = .left
        button.setImage(image, for: .normal)
        let buttonWidth = size.width + image.size.width + edgeMargin
        button.frame = CGRect(x:titleButtonWidth, y: (topTitleScrollView.bounds.height - 32)/2, width: buttonWidth, height: 32)
        button.center.y = topTitleScrollView.center.y
        button.backgroundColor = .white
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.layer.cornerRadius = 10
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 0)
        button.tag = index
        button.addTarget(self, action: #selector(selectButton(button:)), for: .touchUpInside)
        titleButtonWidth += buttonWidth + titleMargin
        titleButtons.append(button)
        topTitleScrollView.addSubview(button)
        topTitleScrollView.contentSize.width = titleButtonWidth
    }
    
    @objc private func selectButton(button: UIButton){
        button.isSelected = !button.isSelected
        if button.isSelected {
            button.backgroundColor = .cyan
            button.setTitleColor(.white, for: .selected)
            setAnimation(button: button)
        }else{
            button.backgroundColor = .white
            button.setTitleColor(.darkGray, for: .selected)
            removeAnimation(button: button)
        }
        selectedButton = button
    }
    
    private func setAnimation(button: UIButton){
        for item in titleButtons{
            if item.tag != button.tag{
                UIView.animate(withDuration: 0.25) {
                    item.alpha = 0.0
                    button.transform = CGAffineTransform(translationX: -(button.frame.maxX - (button.frame.width + titleMargin)), y: 0)
                    self.topTitleScrollView.contentSize.width = kScreenWidth
                }
            }
        }
    }
    
    private func removeAnimation(button: UIButton){
        for item in titleButtons{
            UIView.animate(withDuration: 0.25) {
                item.alpha = 1.0
                button.transform = .identity
                self.topTitleScrollView.contentSize.width = self.titleButtonWidth
            }
        }
    }
}

extension JS_HomeController:UITableViewDelegate,UITableViewDataSource{
    /**
     * DataSource
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return resModels?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: homeContentIdentifier, for: indexPath) as! JS_HomeContentCell
        cell.resModel = resModels?[indexPath.row]
        return cell
    }
    
    /**
     * Delegate
     */
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY: CGFloat = contentTableView.contentOffset.y
        if offsetY > 0 {
            topConstraint.constant = -offsetY
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = (tableView.cellForRow(at: indexPath) as! JS_HomeContentCell)
        let menuVC = JS_MenuViewController.init(nibName: "JS_MenuViewController", bundle: nil)
        menuVC.image = selectedCell.contentImageView.image
        self.present(menuVC, animated: true) {
            
        }
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1)
        UIView.animate(withDuration: 0.25) {
            cell.layer.transform = CATransform3DMakeScale(1, 1, 1)
        }
    }
}
