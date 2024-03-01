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
    
    func addFavorite(id: String) {
        let item = FavoriteCoin(id)
        do {
            try realm.write {
                realm.add(item)
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
