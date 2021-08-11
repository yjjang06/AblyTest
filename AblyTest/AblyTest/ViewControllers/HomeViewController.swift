//
//  HomeViewController.swift
//  AblyTest
//
//  Created by yjjang on 2021/08/08.
//

import UIKit

class HomeViewController: UIViewController {
    
    enum Sections: Int {
        case Banner = 0
        case Goods
        case SectionCount
    }
    
    private let BannerCellIdentifier: String = "BannerCellIdentifier"
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
    
    private var refreshControl: UIRefreshControl!
    
    private lazy var viewModel: HomeListViewModel = {
        let vm = HomeListViewModel()
        return vm
    }()
    
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
        
        collectionView.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCellIdentifier)
        collectionView.register(GoodsCollectionViewCell.self, forCellWithReuseIdentifier: GoodsCellIdentifier)
        
        let tmpRefreshControl = UIRefreshControl()
        tmpRefreshControl.addTarget(self, action: #selector(reload), for: .valueChanged)
        refreshControl = tmpRefreshControl
        collectionView.addSubview(refreshControl)
        
        viewModel.dataChanged {
            if self.refreshControl.isRefreshing {
                self.refreshControl.endRefreshing()
            }
            
            self.collectionView.reloadData()
        }
        viewModel.firstList()
    }
    
    @objc private func reload() {
        viewModel.firstList()
    }
}

//MARK:- UICollectionView Delegate, DataSource
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Sections.SectionCount.rawValue
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == Sections.Banner.rawValue {
            let count = viewModel.bannerCount()
            return count > 0 ? 1 : 0
        }
        else {
            return viewModel.goodsCount()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == Sections.Banner.rawValue {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCellIdentifier, for: indexPath) as! BannerCollectionViewCell
            if viewModel.bannerDataChanged {
                viewModel.bannerDataChanged = false
                cell.setBannerList(viewModel.bannerList())
            }
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GoodsCellIdentifier, for: indexPath) as! GoodsCollectionViewCell
            let index = indexPath.item
            let goods = viewModel.goods(at: index)
            var isZzim: Bool = false
            if goods != nil {
                isZzim = ZzimListSingleton.shared.isZzimGoods(id: goods!.id)
            }
            cell.itemIndex = index
            cell.delegate = self
            cell.setGoodsImage(url: goods?.image)
            cell.setRateText(actualPrice: goods?.actualPrice, price: goods?.price)
            cell.setPriceText(goods?.price)
            cell.setGoodsName(goods?.name)
            cell.setIsNewHidden((goods?.isNew ?? false) ? false : true)
            cell.setSellCountText(goods?.sellCount)
            cell.setIsZzim(isZzim)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == Sections.Banner.rawValue {
            return BannerCollectionViewCell.getSize(maxWidth: collectionView.frame.width)
        }
        
        return CGSize(width: collectionView.frame.width, height: 124.0)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if viewModel.goodsCount() == 0 {
            return
        }
        
        // 마지막 셀이 보여지는 위치로 스크롤 됐을 때 next 호출
        let lastIndexPath = IndexPath(item: viewModel.goodsCount() - 1, section: Sections.Goods.rawValue)
        let visible = collectionView.indexPathsForVisibleItems
        if visible.count > 0, visible.contains(lastIndexPath) {
            viewModel.next()
        }
    }
}

//MARK:- GoodsCollectionViewCellDelegate
extension HomeViewController: GoodsCollectionViewCellDelegate {
    func goodsCollectionViewCellDidSelectZzim(cell: GoodsCollectionViewCell, index: Int) {
        if let goods = viewModel.goods(at: index) {
            let isZzim = ZzimListSingleton.shared.isZzimGoods(id: goods.id)
            if isZzim {
                ZzimListSingleton.shared.removeZzimGoods(goods: goods)
            }
            else {
                ZzimListSingleton.shared.addZzimGoods(goods: goods)
            }
            cell.setIsZzim(!isZzim)
        }
    }
}
