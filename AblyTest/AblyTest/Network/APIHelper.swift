//
//  APIHelper.swift
//  AblyTest
//
//  Created by yjjang on 2021/08/08.
//

import Foundation

class APIHelper {
    static func getData(baseUrl: String, path: String?, params: [String:Any]?, completed: @escaping (Result<String, Error>) -> Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                
                var fullUrl: String = baseUrl
                
                // path 추가
                if path != nil, path!.count > 0 {
                    fullUrl = fullUrl + "/" + path!
                }
                
                if params != nil, params!.count > 0 {
                    fullUrl = fullUrl + "?"
                    
                    let paramStr = params!.map { key, value in "\(key)=\(value)" }.joined(separator: "&")
                    fullUrl = fullUrl + paramStr
                }
                
                let url = URL(string: fullUrl)
                
                let json = try String(contentsOf: url!, encoding: .utf8)
                DispatchQueue.main.async {
                    completed(Result.success(json))
                }
            } catch {
                DispatchQueue.main.async {
                    completed(Result.failure(error))
                }
            }
        }
    }
}
