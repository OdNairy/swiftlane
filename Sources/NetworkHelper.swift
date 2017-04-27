//
//  NetworkHelper.swift
//  swiftlane
//
//  Created by Roman Gardukevich on 28/10/16.
//
//

import Foundation

private let DefaultTimeoutLengthInSeconds: DispatchTimeInterval = .seconds(10)
extension URLSession {
    enum HTTPMethod: String {
        case get, post, delete
        
        func toHTTPString() -> String {
            return self.rawValue.uppercased()
        }
    }
    
    @discardableResult func run(_ request: URLRequest) -> (data: String?, response: HTTPURLResponse?, error: Error?) {
        let semaphore = DispatchSemaphore(value: 0)
        
        var result:(data: String?, response: HTTPURLResponse?, error: Error?)
        dataTask(with: request){ serverResult in
            if let data = serverResult.0 {
                result.data = String(data: data, encoding: .utf8)
            }
            result.response = serverResult.1 as? HTTPURLResponse
            result.error = serverResult.2

            semaphore.signal()
        }.resume()
        
        let _ = semaphore.wait(timeout: .now() + DefaultTimeoutLengthInSeconds)

        return result
    }
    
    @discardableResult func run(_ url: URL) -> (data: String?, response: HTTPURLResponse?, error: Error?){
        return run(URLRequest(url: url))
    }
    
    @discardableResult func run(_ urlString: String) -> (data: String?, response: HTTPURLResponse?, error: Error?){
        return run(URL(string: urlString)!)
    }
    
    @discardableResult func run(method: String, url urlString: String, data: JSONConvertible? = nil,
                                headers: [String:String]? = ["Content-Type":"application/json"]) -> (data: String?, response: HTTPURLResponse?, error: Error?) {
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = method
        request.httpBody = data?.toJSONData()
        request.allHTTPHeaderFields = headers
        
        return run(request)
    }
    
    @discardableResult func run(method: HTTPMethod, url urlString: String, data: JSONConvertible? = nil,
                                headers: [String:String]? = ["Content-Type":"application/json"]) -> (data: String?, response: HTTPURLResponse?, error: Error?) {
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = method.toHTTPString()
        request.httpBody = data?.toJSONData()
        request.allHTTPHeaderFields = headers
        
        return run(request)
    }
}
