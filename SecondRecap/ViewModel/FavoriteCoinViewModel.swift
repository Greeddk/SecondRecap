//
//  FavoriteCoinViewModel.swift
//  SecondRecap
//
//  Created by Greed on 3/1/24.
//

import Foundation

class FavoriteCoinViewModel {
    
    let repository = FavoriteRepository()
    let apiManager = APIManager.shared
    
    var inputFetchFavoriteListTrigger: Observable<Void?> = Observable(nil)
    
    var outputFavoriteList: Observable<Array<CoinMarket>?> = Observable(nil)
    
    init() {
        inputFetchFavoriteListTrigger.bind { _ in
            self.fetchFavoriteCoinList()
        }
    }
    
    private func fetchFavoriteCoinList() {
        outputFavoriteList.value = nil
        let list = repository.fetchFavoriteItem()
        var tmpList: [CoinMarket] = []
        for item in list {
            let sparkline = Array(item.sparkline)
            let tmpItem: CoinMarket = CoinMarket(id: item.id, name: item.name, image: item.image, symbol: item.symbol, current_price: item.current_price, change_percentage: item.change_percentage, low: item.low, high: item.high, ath: item.ath, atl: item.atl, last_updated: item.last_updated, sparkline: Price(price: sparkline))
            tmpList.append(tmpItem)
        }
        outputFavoriteList.value = tmpList
    }
    
}
