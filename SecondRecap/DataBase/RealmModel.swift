//
//  ReamlModel.swift
//  SecondRecap
//
//  Created by Greed on 3/1/24.
//

import Foundation
import RealmSwift

class FavoriteCoin: Object {
    @Persisted(primaryKey: true) var id: String
    
    convenience init(_ id: String) {
        self.init()
        self.id = id
    }
}

class CoinData: Object {
    @Persisted(primaryKey: true) var id: String
    @Persisted var name: String
    @Persisted var symbol: String
    @Persisted var price: String
    @Persisted var changePercent: String
    @Persisted var sparkline: List<Double>
}

