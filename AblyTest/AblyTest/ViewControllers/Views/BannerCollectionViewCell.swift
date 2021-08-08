//
//  BannerCollectionViewCell.swift
//  AblyTest
//
//  Created by yjjang on 2021/08/08.
//

import UIKit
import SnapKit

class BannerCollectionViewCell: UICollectionViewCell {
    
    private lazy var scrollView: UIScrollView = {
        let sc = UIScrollView()
        return sc
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    static func getSize(maxWidth: CGFloat) -> CGSize {
        return CGSize(width: maxWidth, height: maxWidth * (263.0/375.0))
    }
}
