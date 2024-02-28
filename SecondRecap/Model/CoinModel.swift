//
//  CoinModel.swift
//  SecondRecap
//
//  Created by Greed on 2/28/24.
//

import Foundation

struct CoinTrending: Decodable {
    let coins: [Coin]
    let nfts: [NFT]
}

struct Coin: Decodable {
    let coin_id: Int
    let name: String
    let symbol: String
    let icon: String // Coin image / 원래 이름 small
    let rank: Int // 시가총액 순위 / 원래 이름 market_cap_rank
    let data: CoinPrice
    
    enum CodingKeys: String, CodingKey {
        case coin_id
        case name
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
    let price_change_percentage_24h: [ChangePercent]
}

struct NFTPrice: Decodable {
    let floor_price: String
    let percentage_change: String // 원래 이름 floor_price_in_usd_24h_percentage_change
    
    enum CodingKeys: String, CodingKey {
        case floor_price
        case percentage_change = "floor_price_in_usd_24h_percentage_change"
    }
}

struct ChangePercent: Decodable {
    let krw: Double
}
