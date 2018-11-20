//
//  JS_WelcomeView.swift
//  GlovoSimulator
//
//  Created by JS_Coder on 11/8/18.
//  Copyright © 2018 JS_Coder. All rights reserved.
//

import UIKit

class JS_WelcomeView: UIViewController {

    
    var images: [UIImage] = []
    
    lazy var imageView: UIImageView = {
        let v = UIImageView()
        v.frame.size = CGSize(width: 100, height: 100)
        v.center = self.view.center
        return v
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(hexString: "#FFFF00")
        
        for index in 0 ..< 20 {
            if let loadimage = UIImage(named: "loader_"+"\(index)") {images.append(loadimage)}else{
                continue
            }
            
        }
        imageView.animationImages = images
        imageView.animationRepeatCount = 5
        imageView.animationDuration = 1.00
        imageView.startAnimating()
        
       
        
//        UIView.animateKeyframes(withDuration: 2.0, delay: 2.0, options: .autoreverse, animations: {
//            let rootView = JS_HomeController.init(nibName: "JS_HomeController", bundle: nil)
//            let baseNavi = UINavigationController(rootViewController: rootView)
//            UIApplication.shared.keyWindow?.rootViewController = baseNavi
//        }) { (_) in
//            
//        }
    }
    
    
    

    

}
