//
//  CoinSearchViewModel.swift
//  SecondRecap
//
//  Created by Greed on 2/29/24.
//

import Foundation

class CoinSearchViewModel {
    
    let apiManager = APIManager.shared
    
    var inputSearchText: Observable<String?> = Observable(nil)
    var outputSearchText: Observable<String?> = Observable(nil)
    
    var outputSearchResult: Observable<CoinSearch> = Observable(CoinSearch(coins: []))
    
    init() {
        inputSearchText.bind { value in
            self.outputSearchText.value = value
            self.callRequest(query: value)
        }
    }
    
    private func callRequest(query: String?) {
        guard let query = query else { return }
        apiManager.callRequest(type: CoinSearch.self, api: .search(query: query)) { value in
            self.outputSearchResult.value = value
        }
    }
}
