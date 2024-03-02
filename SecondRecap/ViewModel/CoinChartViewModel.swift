//
//  CoinChartViewModel.swift
//  SecondRecap
//
//  Created by Greed on 2/29/24.
//

import Foundation

final class CoinChartViewModel {
    
    let apiManager = APIManager.shared
    let repository = FavoriteRepository()

    var inputId: Observable<String?> = Observable(nil)

    var inputCoinMarket: Observable<CoinMarket?> = Observable(nil)
    var inputFavoriteButtonClicked: Observable<String> = Observable("")
    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    
    var outputCoinMarket: Observable<CoinMarket?> = Observable(nil)
    var outputFavoriteStatus: Observable<Bool> = Observable(false)
    
    init() {
        inputId.bind { value in
            guard let value = value else { return }
            self.callRequest(value)
        }
        inputFavoriteButtonClicked.bind { id in
            self.favoriteStatusToggle(id: id)
        }
        inputCoinMarket.bind { value in
            if let id = self.inputCoinMarket.value?.id {
                self.fetchFavoriteStatus(id: id)
            }
        }
        inputViewDidLoadTrigger.bind { _ in
            if let id = self.outputCoinMarket.value?.id {
                self.fetchFavoriteStatus(id: id)
            }
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
    
    private func callRequest(_ id: String) {
        apiManager.callRequest(type: [CoinMarket].self, api: .coinInfo(id: id)) { value in
            self.outputCoinMarket.value = value.first
        }
    }
    
    private func favoriteStatusToggle(id: String) {
        let list = repository.fetchFavoriteItem().filter { $0.id == id }
        if list.count > 0 {
            repository.subtractFavorite(id: id)
            outputFavoriteStatus.value = false
        } else {
            guard let item = outputCoinMarket.value else { return }
            repository.addFavorite(item: item)
            outputFavoriteStatus.value = true
        }
    }
}

