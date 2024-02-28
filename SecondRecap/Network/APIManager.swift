//
//  APIManager.swift
//  SecondRecap
//
//  Created by Greed on 2/28/24.
//

import Foundation
import Alamofire

class APIManager {
    
    let shared = APIManager()
    
    func callRequest<T:Decodable>(type: T, api: CoinAPI, completionHandler: @escaping (T) -> Void) {
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
