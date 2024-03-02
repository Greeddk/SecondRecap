//
//  FavoriteRepository.swift
//  SecondRecap
//
//  Created by Greed on 3/1/24.
//

import Foundation
import RealmSwift

class FavoriteRepository {
    
    private var realm = try! Realm()
    
    func addFavorite(item: CoinMarket) {
        let favoriteCoin = FavoriteCoin(id: item.id, name: item.name, image: item.image, symbol: item.symbol, current_price: item.current_price, change_percentage: item.change_percentage, low: item.low, high: item.high, ath: item.ath, atl: item.atl, last_updated: item.last_updated)
        for value in item.sparkline.price {
            favoriteCoin.sparkline.append(value)
        }
        do {
            try realm.write {
                realm.add(favoriteCoin)
            }
        } catch {
            print(error)
        }
    }
    
    func subtractFavorite(id: String) {
        let targetItem = realm.objects(FavoriteCoin.self).filter { $0.id == id }
        do {
            try realm.write {
                realm.delete(targetItem)
            }
        } catch {
            print("삭제 실패", error)
        }
    }
    
    func fetchFavoriteItem() -> [FavoriteCoin] {
        return Array(realm.objects(FavoriteCoin.self))
    }
    
}
