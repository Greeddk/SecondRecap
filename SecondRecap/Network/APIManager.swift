//
//  APIManager.swift
//  SecondRecap
//
//  Created by Greed on 2/28/24.
//

import Foundation
import Alamofire

final class APIManager {
    
    static let shared = APIManager()
    // TODO: 실패경우 핸들링, 타이머!
    
    func callRequest<T:Decodable>(type: T.Type, api: CoinAPI, completionHandler: @escaping (T) -> Void) {
        
        let url = URLRequest(url: api.endPoint)
        AF.request(url).responseDecodable(of: T.self) { success in
            switch success.result {
            case .success(let success):
                completionHandler(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
}
