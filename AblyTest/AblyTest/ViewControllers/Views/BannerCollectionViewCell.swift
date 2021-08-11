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
    
    private lazy var pageBgView: UIView = {
        let v = UIView()
        v.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        v.layer.cornerRadius = 12.5
        v.layer.masksToBounds = true
        return v
    }()
    
    private lazy var pageLabel: UILabel = {
        let l = UILabel()
        l.font = UIFont(name: "AppleSDGothicNeo-Regular", size: 13.0)
        l.textColor = .white
        l.textAlignment = .center
        return l
    }()
    
    private var totalPage: Int = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        scrollView.isPagingEnabled = true
        scrollView.delegate = self
        self.contentView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        self.contentView.addSubview(pageBgView)
        pageBgView.snp.makeConstraints { make in
            make.width.equalTo(48)
            make.height.equalTo(24)
            make.trailing.bottom.equalToSuperview().offset(-16)
        }
        
        self.contentView.addSubview(pageLabel)
        pageLabel.snp.makeConstraints { make in
            make.center.equalTo(pageBgView)
            make.width.height.equalTo(pageBgView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    static func getSize(maxWidth: CGFloat) -> CGSize {
        return CGSize(width: maxWidth, height: maxWidth * (263.0/375.0))
    }
    
    func setBannerList(_ bannerList: [Banner]?) {
        layoutIfNeeded()
        
        let scSubViews = scrollView.subviews
        if scSubViews.count > 0 {
            for view in scSubViews {
                view.removeFromSuperview()
            }
        }
        
        scrollView.setContentOffset(.zero, animated: false)
        updatePage()
        
        guard let list = bannerList, list.count > 0 else {
            totalPage = 0
            return
        }
        
        totalPage = list.count
        updatePage()
        
        let size = scrollView.bounds.size
        scrollView.contentSize = CGSize(width: size.width * CGFloat(totalPage), height: size.height)
        
        for i in 0..<list.count {
            let bannerData = list[i]
            let view = UIImageView()
            view.frame = CGRect(x: size.width * CGFloat(i), y: 0, width: size.width, height: size.height)
            scrollView.addSubview(view)
            
            view.sd_setImage(with: URL(string: bannerData.image), completed: nil)
        }
    }
    
    private func updatePage() {
        let width: CGFloat = scrollView.bounds.size.width
        let x:CGFloat = scrollView.contentOffset.x
        
        let curr = Int( x / width ) + 1
        
        let text = String(format: "%d / %d", curr, totalPage)
        pageLabel.attributedText = AttributedString.getAttrString(text: text, letterSpacing: -0.4)
    }
}

extension BannerCollectionViewCell: UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            updatePage()
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updatePage()
    }
}
