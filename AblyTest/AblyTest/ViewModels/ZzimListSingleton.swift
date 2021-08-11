//
//  ZzimListSingleton.swift
//  AblyTest
//
//  Created by yjjang on 2021/08/11.
//

import Foundation

/// 찜 목록을 관리하기 위한 singleton
class ZzimListSingleton {
    static let shared = ZzimListSingleton()
    private var list: [Goods]
    private init() {
        list = Array()
    }
    
    func getZzimList() -> [Goods] {
        return list
    }
    
    func getZzimListCount() -> Int {
        return list.count
    }
    
    func getZzimGoods(index: Int) -> Goods? {
        guard index < list.count else {
            return nil
        }
        return list[index]
    }
    
    func isZzimGoods(id: Int) -> Bool {
        guard list.count > 0 else {
            return false
        }
        
        let first = list.first(where: { $0.id == id })
        if first != nil {
            return true
        }
        return false
    }
    
    func addZzimGoods(goods: Goods) {
        list.append(goods)
    }
    
    func removeZzimGoods(goods: Goods) {
        list.removeAll(where: { $0.id == goods.id })
    }
}
