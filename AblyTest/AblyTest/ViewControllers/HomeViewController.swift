//
//  HomeViewController.swift
//  AblyTest
//
//  Created by yjjang on 2021/08/08.
//

import UIKit

class HomeViewController: UIViewController {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let title: String = "홈"
        self.title = title
        self.tabBarItem = UITabBarItem(title: title,
                                       image: UIImage(named: "iconHome")?.withRenderingMode(.alwaysOriginal),
                                       selectedImage: UIImage(named: "iconHomeActive")?.withRenderingMode(.alwaysOriginal))
        self.navigationController?.navigationBar.backgroundColor = ConstantColor.naviBarBgColor
        self.navigationController?.navigationBar.tintColor = ConstantColor.naviBarTintColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
