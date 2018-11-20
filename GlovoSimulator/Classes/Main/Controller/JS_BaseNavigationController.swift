//
//  JS_BaseNavigationController.swift
//  GlovoSimulator
//
//  Created by JS_Coder on 11/6/18.
//  Copyright © 2018 JS_Coder. All rights reserved.
//

import UIKit

class JS_BaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationBar.setBackgroundImage(UIImage(named: "naviBarBackground"), for: .default)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
