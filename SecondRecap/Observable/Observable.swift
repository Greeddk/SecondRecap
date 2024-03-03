//
//  Observable.swift
//  SecondRecap
//
//  Created by Greed on 2/27/24.
//

import Foundation

class Observable<T> {
    
    private var closure: ((T) -> Void)?
    
    var value: T {
        didSet {
            closure?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void ) {
        closure(value) //이게 있으면 콜을 두번해서 곤란..한데 없으면 또 즐겨찾기가 안됨.
        self.closure = closure
    }
    
    func apiBind(_ closure: @escaping (T) -> Void ) {
        self.closure = closure
    }
}
