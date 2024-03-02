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

    //top15나 검색에서 온 경우 따로 콜해야함
    //id는 검색페이지나 top에서 들어왔을때 정보를 요청하기 위함
    var inputId: Observable<String?> = Observable(nil)
    //inputCoinMarket은 10초마다 call 되는 데이터
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
        inputViewDidLoadTrigger.bind { _ in
            if let id = self.outputCoinMarket.value?.id {
                self.fetchFavoriteStatus(id: id)
            }
            if let id = self.inputCoinMarket.value?.id {
                self.fetchFavoriteStatus(id: id)
            }
        }
    }
    
    private func fetchFavoriteStatus(id: String) {
        let list = repository.fetchFavoriteItem().filter { $0.id == id }
        if list.count > 0 {
            outputFavoriteStatus.value = true
        } else {
            outputFavoriteStatus.value = false
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
            repository.addFavorite(id: id)
            outputFavoriteStatus.value = true
        }
    }
}
