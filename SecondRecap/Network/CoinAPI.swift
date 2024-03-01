//
//  CoinAPO.swift
//  SecondRecap
//
//  Created by Greed on 2/28/24.
//

import Foundation

enum CoinAPI {
    case trending
    case search(query: String)
    case coinInfo(id: String)
    
    var baseURL: String {
        return "https://api.coingecko.com/api/v3/"
    }
    
    var endPoint: URL {
        switch self {
        case .trending:
            return URL(string: baseURL + "search/trending")!
        case .search(let query):
            return URL(string: baseURL + "search?query=\(query)")!
        case .coinInfo(let id):
            return URL(string: baseURL + "coins/markets?vs_currency=krw&ids=\(id)&sparkline=true")!
        }
    }
    
}
