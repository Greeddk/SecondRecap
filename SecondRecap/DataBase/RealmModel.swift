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
    @Persisted var name: String
    @Persisted var image: String
    @Persisted var symbol: String
    @Persisted var current_price: Double
    @Persisted var change_percentage: Double
    @Persisted var low: Double
    @Persisted var high: Double
    @Persisted var ath: Double
    @Persisted var atl: Double
    @Persisted var last_updated: String
    @Persisted var sparkline: List<Double>

    convenience init(id: String, name: String, image: String, symbol: String, current_price: Double, change_percentage: Double, low: Double, high: Double, ath: Double, atl: Double, last_updated: String) {
        self.init()
        self.id = id
        self.name = name
        self.image = image
        self.symbol = symbol
        self.current_price = current_price
        self.change_percentage = change_percentage
        self.low = low
        self.high = high
        self.ath = ath
        self.atl = atl
        self.last_updated = last_updated
    }
}
