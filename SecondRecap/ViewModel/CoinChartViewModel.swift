//
//  CoinChartViewModel.swift
//  SecondRecap
//
//  Created by Greed on 2/29/24.
//

import Foundation

final class CoinChartViewModel {
    
    let apiManager = APIManager.shared
    
    //1,3 페이지 같은 경우 Reaml으로 저장된 값을 통해 불러야함
    //top15나 검색에서 온 경우 다시 콜해야함
    
    //id는 검색페이지나 top에서 들어왔을때 정보를 요청하기 위함
    var inputId: Observable<String?> = Observable(nil)
    //inputCoinMarket은 10초마다 call 되는 데이터
    var inputCoinMarket: Observable<CoinMarket?> = Observable(nil)
    
    var outputCoinMarket: Observable<CoinMarket?> = Observable(nil)
    
    init() {
        inputId.bind { value in
            guard let value = value else { return }
            self.callRequest(value)
        }
    }
    
    private func callRequest(_ id: String) {
        apiManager.callRequest(type: [CoinMarket].self, api: .coinInfo(id: id)) { value in
            self.outputCoinMarket.value = value.first
        }
    }
}
