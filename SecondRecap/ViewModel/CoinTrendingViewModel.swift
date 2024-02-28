//
//  CoinTrendingViewModel.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import Foundation

class CoinTrendingViewModel {
    
    let apiManager = APIManager.shared

    var inputViewDidLoadTrigger: Observable<Void?> = Observable(nil)
    
    
    var outputList: Observable<CoinTrending> = Observable(CoinTrending(coins: [], nfts: []))
    
    init() {
        inputViewDidLoadTrigger.bind { _ in
            self.requestCall()
        }
    }
    
    private func requestCall() {
        apiManager.callRequest(type: CoinTrending.self, api: .trending) { success in
            self.outputList.value = success
        }
    }
    
}
