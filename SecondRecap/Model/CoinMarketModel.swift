//
//  CoinMarketModel.swift
//  SecondRecap
//
//  Created by Greed on 2/29/24.
//

import Foundation

struct CoinMarket: Decodable {
    let id: String
    let name: String
    let image: String
    let symbol: String
    let current_price: Double
    let change_percentage: Double
    let low: Double
    let high: Double
    let ath: Double
    let atl: Double
    let last_updated: String
    let sparkline: Price
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case image
        case symbol
        case current_price
        case change_percentage = "price_change_percentage_24h"
        case low = "low_24h"
        case high = "high_24h"
        case ath
        case atl
        case last_updated
        case sparkline = "sparkline_in_7d"
    }
}

struct Price: Decodable {
    let price: [Double]
}
