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
        inputViewDidLoadTrigger.bind { _ in
            self.requestTrendingCall()
            self.requestFavoriteCoinsCall()
        }
        inputFavoriteListReloadDataTrigger.bind { _ in
            self.fetchFavoriteCoinList()
        }

    }
    
    private func requestTrendingCall() {
        callTrending()
        _ = Timer.scheduledTimer(timeInterval: 120.0, target: self, selector: #selector(callTrending), userInfo: nil, repeats: true)
    }
    
    @objc 
    private func callTrending()
    {
        print(#function)
        var topFifteen: [Item] = []
        let group = DispatchGroup()
        group.enter()
        apiManager.callRequest(type: CoinTrending.self, api: .trending) { value in
            self.outputList.value = value
            topFifteen = value.coins
            group.leave()
        }
        group.notify(queue: .global()) {
            var tmpId = ""
            for item in topFifteen {
                if item == topFifteen.last {
                    tmpId.append(item.item.id)
                } else {
                    tmpId.append(item.item.id + ",")
                }
            }
            self.apiManager.callRequest(type: [CoinMarket].self, api: .coinInfo(id: tmpId)) { value in
                self.outputTopFifteenList.value = value
            }
        }
    }
    //TODO: call 호출이 2번 안되게 설정이 필요
    private func requestFavoriteCoinsCall() {
        callFavoriteCoinsList()
        _ = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(callFavoriteCoinsList), userInfo: nil, repeats: true)
    }
    
    @objc
    private func callFavoriteCoinsList() {
        //TODO: 콜을 받아서 realm 데이터를 업데이트 시켜서 fetchFavoriteCoinList를 실행
        let favoriteItems = repository.fetchFavoriteItem()
        if favoriteItems.count != 0 {
            print(#function)
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
        print(#function)
        outputFavoriteList.value = []
        let list = repository.fetchFavoriteItem()
        var tmpList: [CoinMarket] = []
        for item in list {
            let sparkline = Array(item.sparkline)
            var tmpItem: CoinMarket = CoinMarket(id: item.id, name: item.name, image: item.image, symbol: item.symbol, current_price: item.current_price, change_percentage: item.change_percentage, low: item.low, high: item.high, ath: item.ath, atl: item.atl, last_updated: item.last_updated, sparkline: Price(price: sparkline))
            tmpList.append(tmpItem)
        }
        outputFavoriteList.value = tmpList
    }
    
}
