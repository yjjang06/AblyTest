//
//  ZzimViewController.swift
//  AblyTest
//
//  Created by yjjang on 2021/08/08.
//

import UIKit

class ZzimViewController: UIViewController {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        let title: String = "좋아요"
        self.title = title
        self.tabBarItem = UITabBarItem(title: title,
                                       image: UIImage(named: "iconZzim")?.withRenderingMode(.alwaysOriginal),
                                       selectedImage: UIImage(named: "iconZzimActive")?.withRenderingMode(.alwaysOriginal))
        self.navigationController?.navigationBar.backgroundColor = ConstantColor.naviBarBgColor
        self.navigationController?.navigationBar.tintColor = ConstantColor.naviBarTintColor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
