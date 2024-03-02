//
//  CoinModel.swift
//  SecondRecap
//
//  Created by Greed on 2/28/24.
//

import Foundation

struct CoinTrending: Decodable {
    let coins: [Item]
    let nfts: [NFT]
}

struct Item: Decodable, Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.item.id == rhs.item.id
    }
    
    let item: Coin
}

struct Coin: Decodable {
    let id: String
    let name: String
    let thumb: String?
    let symbol: String
    let icon: String? // Coin image
    let rank: Int? // 시가총액 순위 
    let data: CoinPrice?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case thumb
        case symbol
        case icon = "small"
        case rank = "market_cap_rank"
        case data
    }
}

struct NFT: Decodable {
    let id: String
    let name: String
    let thumb: String
    let data: NFTPrice
}

struct CoinPrice: Decodable {
    let price: String
    let change_percentage: ChangePercent
    
    enum CodingKeys: String, CodingKey {
        case price
        case change_percentage = "price_change_percentage_24h"
    }
}

struct NFTPrice: Decodable {
    let floor_price: String
    let change_percentage: String
    
    enum CodingKeys: String, CodingKey {
        case floor_price
        case change_percentage = "floor_price_in_usd_24h_percentage_change"
    }
}

struct ChangePercent: Decodable {
    let krw: Double
}
