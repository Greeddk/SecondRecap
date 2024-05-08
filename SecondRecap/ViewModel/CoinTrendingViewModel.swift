//
//  CoinTrendingViewModel.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import Foundation

final class CoinTrendingViewModel {
    
    let apiManager = APIManager.shared
    let repository = FavoriteRepository()

    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    var inputFavoriteListReloadDataTrigger: Observable<Void?> = Observable(nil)
    
    var outputList: Observable<CoinTrending> = Observable(CoinTrending(coins: [], nfts: []))
    var outputFavoriteList: Observable<Array<CoinMarket>> = Observable([])
    var outputTopFifteenList: Observable<Array<CoinMarket>> = Observable([])
    
    init() {
        inputViewDidLoadTrigger.apiBind { _ in
            self.requestTrendingCall()
            self.requestFavoriteCoinsCall()
        }
        inputFavoriteListReloadDataTrigger.apiBind { _ in
            self.fetchFavoriteCoinList()
        }

    }
    
    private func requestTrendingCall() {
        callTrending()
        _ = Timer.scheduledTimer(timeInterval: 45.0, target: self, selector: #selector(callTrending), userInfo: nil, repeats: true)
    }
    
    @objc 
    private func callTrending()
    {
        apiManager.callRequest(type: CoinTrending.self, api: .trending) { value in
            print(value)
            self.outputList.value = value
        }
    }

    private func requestFavoriteCoinsCall() {
        callFavoriteCoinsList()
        _ = Timer.scheduledTimer(timeInterval: 45.0, target: self, selector: #selector(callFavoriteCoinsList), userInfo: nil, repeats: true)
    }
    
    @objc
    private func callFavoriteCoinsList() {
        let favoriteItems = repository.fetchFavoriteItem()
        if favoriteItems.count != 0 {
            var tmpId = ""
            for item in favoriteItems {
                if item == favoriteItems.last {
                    tmpId.append(item.id)
                } else {
                    tmpId.append(item.id + ",")
                }
            }
            apiManager.callRequest(type: [CoinMarket].self, api: .coinInfo(id: tmpId)) { value in
                for item in value {
                    self.repository.updateItem(id: item.id, updateValue: item)
                }
                self.fetchFavoriteCoinList()
            }
        }
    }
    
    private func fetchFavoriteCoinList() {
        outputFavoriteList.value = []
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
