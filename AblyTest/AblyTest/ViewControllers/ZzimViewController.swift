//
//  ZzimViewController.swift
//  AblyTest
//
//  Created by yjjang on 2021/08/08.
//

import UIKit
import SnapKit

class ZzimViewController: UIViewController {
    
    private let GoodsCellIdentifier: String = "GoodsCellIdentifier"
    
    private lazy var layout: UICollectionViewFlowLayout = {
        let l = UICollectionViewFlowLayout()
        return l
    }()
    
    private lazy var collectionView: UICollectionView = {
        let v = UICollectionView.init(frame: self.view.bounds, collectionViewLayout: layout)
        v.backgroundColor = .white
        return v
    }()
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.alwaysBounceVertical = true
        
        collectionView.register(GoodsCollectionViewCell.self, forCellWithReuseIdentifier: GoodsCellIdentifier)
    }
}

//MARK:- UICollectionView Delegate, DataSource
extension ZzimViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ZzimListSingleton.shared.getZzimListCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoodsCellIdentifier, for: indexPath) as! GoodsCollectionViewCell
        let index = indexPath.item
        let goods = ZzimListSingleton.shared.getZzimGoods(index: index)
        cell.cellType = .Zzim
        cell.itemIndex = index
        cell.setGoodsImage(url: goods?.image)
        cell.setRateText(actualPrice: goods?.actualPrice, price: goods?.price)
        cell.setPriceText(goods?.price)
        cell.setGoodsName(goods?.name)
        cell.setIsNewHidden((goods?.isNew ?? false) ? false : true)
        cell.setSellCountText(goods?.sellCount)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 124.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
}
