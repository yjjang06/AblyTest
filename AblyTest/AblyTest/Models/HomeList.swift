//
//  HomeList.swift
//  AblyTest
//
//  Created by yjjang on 2021/08/08.
//

import Foundation

struct HomeList: Decodable {
    var banners: [Banner]?
    var goods: [Goods]?
    
    mutating func appendGoodsList(_ goods: [Goods]) {
        self.goods?.append(contentsOf: goods)
    }
    
    /// 목록의 마지막 상품 id (String)
    func getLastGoodsId() -> Int? {
        if let lastGoods = self.goods?.last {
            return lastGoods.id
        }
        return nil
    }
}

extension HomeList {
    static func objectFromString(_ jsonString: String) -> HomeList? {
        if let data = jsonString.data(using: .utf8),
           let object = try? JSONDecoder().decode(HomeList.self, from: data) {
            return object
        }
        return nil
    }
}
