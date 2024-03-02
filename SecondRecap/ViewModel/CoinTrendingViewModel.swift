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
    var inputFavoriteListTrigger: Observable<Void?> = Observable(nil)
    var inputFavoriteListReloadDataTrigger: Observable<Void?> = Observable(nil)
    
    var outputList: Observable<CoinTrending> = Observable(CoinTrending(coins: [], nfts: []))
    var outputFavoriteList: Observable<Array<CoinMarket>> = Observable([])
    var outputTopFifteenList: Observable<Array<CoinMarket>> = Observable([])
    
    init() {
        inputViewDidLoadTrigger.bind { _ in
            self.requestTrendingCall()
        }
        inputFavoriteListTrigger.bind { _ in
            self.requestFavoriteCoinsCall()
        }
//        inputFavoriteListReloadDataTrigger.bind { _ in
//            let originFavorite = self.repository.fetchFavoriteItem()
//            if originFavorite.count > self.outputFavoriteList.value.count {
//                //하나가 제거된 상황
//                self.outputFavoriteList.value = self.outputFavoriteList.value.map{ $0.id }.intersection(originFavorite.map { $0.id })
//            } else if originFavorite.count < self.outputFavoriteList.value.count {
//                //하나가 추가된 상황
//            }
//        }
        inputFavoriteListReloadDataTrigger.bind { _ in
            let originFavorite = self.repository.fetchFavoriteItem()
            
            // outputFavoriteList와 originFavorite 간의 공통된 ID 추출
            let commonIds = Set(self.outputFavoriteList.value.map { $0.id })
                .intersection(originFavorite.map { $0.id })
            
            // outputFavoriteList를 공통 요소만 포함하도록 필터링
            let filteredList = self.outputFavoriteList.value.filter { commonIds.contains($0.id) }
            
            self.outputFavoriteList.value = filteredList
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
    
    private func requestFavoriteCoinsCall() {
        callFavoriteCoinsList()
        _ = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(callFavoriteCoinsList), userInfo: nil, repeats: true)
    }
    
    @objc
    private func callFavoriteCoinsList() {
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
                self.outputFavoriteList.value = value
            }
        }
    }
    
}
