//
//  Constants.swift
//  AblyTest
//
//  Created by yjjang on 2021/08/08.
//

import UIKit

struct ConstantColor {
    static let naviBarBgColor: UIColor = colorWithWhite(white: 248, alpha: 0.82)
    static let naviBarTintColor: UIColor = colorWithWhite(white: 3, alpha: 0.25)
    
    static let tabbarSelectedColor: UIColor = colorWithRGBA(red: 237, green: 72, blue: 85, alpha: 1)
    static let tabbarUnselectedColor: UIColor = brownishGrey
    
    static let brownishGrey: UIColor = colorWithWhite(white: 119, alpha: 1)
    static let watermelon: UIColor = colorWithRGBA(red: 255, green: 81, blue: 96, alpha: 1)
    static let black: UIColor = colorWithWhite(white: 31, alpha: 1)
    static let veryLightPink: UIColor = colorWithWhite(white: 238, alpha: 1)
    
    static func colorWithRGBA(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
    }
    
    static func colorWithWhite(white: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor.init(white: white/255.0, alpha: alpha)
    }
}
