//
//  TabBarController.swift
//  AblyTest
//
//  Created by yjjang on 2021/08/08.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.tabBar.tintColor = ConstantColor.tabbarSelectedColor
        self.tabBar.unselectedItemTintColor = ConstantColor.tabbarUnselectedColor
        self.tabBar.isTranslucent = false
    }
    
}
