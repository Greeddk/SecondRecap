//
//  CoinSearchViewModel.swift
//  SecondRecap
//
//  Created by Greed on 2/29/24.
//

import Foundation

final class CoinSearchViewModel {
    
    let apiManager = APIManager.shared
    let repository = FavoriteRepository()
    
    var inputSearchText: Observable<String?> = Observable(nil)
    var inputFavoriteListRequest: Observable<Void?> = Observable(nil)
    var inputFavoriteStatusTrigger: Observable<String?> = Observable(nil)
    var inputFavoriteButtonClicked: Observable<String> = Observable("")
    var inputIndex: Observable<Int> = Observable(0)
    
    var outputSearchText: Observable<String?> = Observable(nil)
    var outputFavoriteStatus: Observable<Bool> = Observable(false)
    var outputToastMessage: Observable<String?> = Observable(nil)
    var outputFavoriteList: Observable<[FavoriteCoin]> = Observable([])
    var outputIndex: Observable<Int> = Observable(0)
    
    var outputSearchResult: Observable<CoinSearch> = Observable(CoinSearch(coins: []))
    
    init() {
        inputSearchText.bind { value in
            self.outputSearchText.value = value
            self.callRequest(query: value)
        }
        inputFavoriteStatusTrigger.bind { id in
            guard let id = id else { return }
            self.fetchFavoriteStatus(id: id)
        }
        inputFavoriteButtonClicked.bind { id in
            self.favoriteStatusToggle(id: id)
        }
        inputFavoriteListRequest.bind { _ in
            self.fetchFavoriteList()
        }
        inputIndex.bind { value in
            self.outputIndex.value = value
        }
    }
    
    private func fetchFavoriteList() {
        outputFavoriteList.value = repository.fetchFavoriteItem()
    }
    
    private func callRequest(query: String?) {
        guard let query = query else { return }
        apiManager.callRequest(type: CoinSearch.self, api: .search(query: query)) { value in
            self.outputSearchResult.value = value
        }
    }
    
    private func fetchFavoriteStatus(id: String) {
        let list = repository.fetchFavoriteItem().filter { $0.id == id }
        if list.isEmpty {
            outputFavoriteStatus.value = false
        } else {
            outputFavoriteStatus.value = true
        }
    }
    
    private func favoriteStatusToggle(id: String) {
        let list = repository.fetchFavoriteItem().filter { $0.id == id }
        if list.count > 0 {
            guard let name = list.first?.name else { return }
            outputToastMessage.value = "\(String(describing: name))이/가 즐겨찾기에서 제거됐습니다."
            outputFavoriteStatus.value = false
            repository.subtractFavorite(id: id)
        } else {
            if repository.fetchFavoriteItem().count >= 10 {
                outputToastMessage.value = "즐겨찾기는 최대 10개의 코인까지만 가능합니다."
            } else {
                guard let coin = outputSearchResult.value.coins.filter( { $0.id == id }).first else { return }
                let item: CoinMarket = CoinMarket(id: coin.id, name: coin.name, image: coin.thumb ?? "", symbol: coin.symbol, current_price: 0 , change_percentage: 0, low: 0, high: 0, ath: 0, atl: 0, last_updated: "", sparkline: Price(price: [0]))
                repository.addFavorite(item: item)
                outputFavoriteStatus.value = true
                outputToastMessage.value = "\(String(describing: coin.name))이/가 즐겨찾기에 추가됐습니다."
            }
        }
    }
    
}
