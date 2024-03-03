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
    var outputToastMessage: Observable<String?> = Observable(nil)
    
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
        if repository.fetchFavoriteItem().count == 0 {
            outputToastMessage.value = "즐겨찾기는 최대 10개의 코인까지만 가능합니다."
        } else {
            let list = repository.fetchFavoriteItem().filter { $0.id == id }
            if list.count > 0 {
                repository.subtractFavorite(id: id)
                outputFavoriteStatus.value = false
                outputToastMessage.value = "\(String(describing: list.first?.name))이/가 즐겨찾기에서 제거됐습니다."
            } else {
                guard let item = outputCoinMarket.value else { return }
                repository.addFavorite(item: item)
                outputFavoriteStatus.value = true
                outputToastMessage.value = "\(String(describing: list.first?.name))이/가 즐겨찾기에 추가됐습니다."
            }
        }
    }
}

