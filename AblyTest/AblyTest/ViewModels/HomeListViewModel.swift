//
//  HomeListViewModel.swift
//  AblyTest
//
//  Created by yjjang on 2021/08/08.
//

import UIKit

protocol HomeListViewModelProtocol {
    func dataChanged(didChange: @escaping() -> Void)
}

class HomeListViewModel: NSObject, HomeListViewModelProtocol {
    
    private let baseUrl: String = "http://d2bab9i9pr8lds.cloudfront.net/api/home"
    
    /// API 호출중인지 체크
    private var isLoading: Bool = false
    /// 마지막 페이지 호출 여부 체크
    private var isLast: Bool = false
    
    private var homeList: HomeList?
    
    var bannerDataChanged: Bool = false
    
    private var didChange: (() -> Void)?
    func dataChanged(didChange: @escaping () -> Void) {
        self.didChange = didChange
    }
    
    // MARK:- banner
    func bannerList() -> [Banner]? {
        return self.homeList?.banners
    }
    
    func bannerCount() -> Int {
        if self.homeList != nil, self.homeList!.banners != nil {
            return self.homeList!.banners!.count
        }
        return 0
    }
    
    func banner(at index: Int) -> Banner? {
        if index < bannerCount(), let item = self.homeList?.banners?[index] {
            return item
        }
        return nil
    }
    
    // MARK:- goods
    func goodsList() -> [Goods]? {
        return self.homeList?.goods
    }
    
    func goodsCount() -> Int {
        if self.homeList != nil, self.homeList!.goods != nil {
            return self.homeList!.goods!.count
        }
        return 0
    }
    
    func goods(at index: Int) -> Goods? {
        if index < goodsCount(), let item = self.homeList?.goods?[index] {
            return item
        }
        return nil
    }
    
    // MARK:- API request
    func firstList() {
        self.homeList = nil
        self.isLast = false
        
        self.bannerDataChanged = true
        
        if self.isLoading {
            return
        }

        self.isLoading = true

        APIHelper.getData(baseUrl: baseUrl, path: nil, params: nil) { result in
            self.isLoading = false
            if let jsonString = try? result.get() {
                let homeList = HomeList.objectFromString(jsonString)
                self.homeList = homeList

                self.didChange?()
            }
        }
    }
    
    func next() {
        if self.isLoading {
            return
        }
        
        if self.isLast {
            return
        }
        
        self.isLoading = true
        
        if let lastGoodsId = homeList?.getLastGoodsId() {
            APIHelper.getData(baseUrl: baseUrl, path: "goods", params: ["lastId":lastGoodsId]) { result in
                self.isLoading = false
                if let jsonString = try? result.get() {
                    let homeList = HomeList.objectFromString(jsonString)
                    if let newGoodsList = homeList?.goods, newGoodsList.count > 0 {
                        self.homeList?.appendGoodsList(newGoodsList)
                        self.didChange?()
                    }
                    else {
                        self.isLast = true
                    }
                }
            }
        }
    }
}
