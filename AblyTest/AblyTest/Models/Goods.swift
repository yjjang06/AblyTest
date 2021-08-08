//
//  Goods.swift
//  AblyTest
//
//  Created by yjjang on 2021/08/08.
//

import Foundation

struct Goods: Decodable {
    let id: Int
    let name: String
    let image: String
    let isNew: Bool
    let sellCount: Int
    let actualPrice: Int
    let price: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case isNew = "is_new"
        case sellCount = "sell_count"
        case actualPrice = "actual_price"
        case price
    }
}
