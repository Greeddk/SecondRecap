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
    
    var inputViewWillAppearTrigger: Observable<Void?> = Observable(nil)
    
    var outputFavoriteList: Observable<Array<CoinMarket>?> = Observable(nil)
    
    init() {
        inputViewWillAppearTrigger.bind { _ in
            self.requestFavoriteCoinsCall()
        }
    }
    
    private func requestFavoriteCoinsCall() {
        let favoriteItems = repository.fetchFavoriteItem()
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
