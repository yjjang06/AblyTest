//
//  Util.swift
//  AblyTest
//
//  Created by yjjang on 2021/08/11.
//

import UIKit

struct AttributedString {
    /// letterSpacing 이 적용된 attributed string
    static func getAttrString(text: String?, letterSpacing: CGFloat) -> NSAttributedString? {
        if let t = text, t.count > 0 {
            let attrStr = NSMutableAttributedString(string: t)
            attrStr.addAttribute(NSAttributedString.Key.kern,
                                 value: letterSpacing,
                                 range: NSRange(location: 0,
                                                length: attrStr.length))
            return attrStr
        }
        return nil
    }
}
