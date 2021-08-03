//
//  HTTPNetwork.swift
//  PositionAssumptionTest
//
//  Created by Byungwook Jeong on 2021/08/01.
//

import Foundation
import Alamofire

struct HTTPNetwork {
    let httpHeaders: HTTPHeaders = [
        "Accept-Language" : "ko-KR"
    ]
    
    func get(path: String, _ completion: @escaping (String) -> Void) {
        AF.request(path, headers: httpHeaders)
            .validate(statusCode: 200 ..< 300)
            .responseString(queue: DispatchQueue.global()) { response in
                switch response.result {
                case .success(let str):
                    completion(str)
                case .failure(let err):
                    print(err.errorDescription ?? "Alamofire Response Error!")
            }
        }
    }
}
