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
    func run(_ request: URLRequest) -> (data: Data?, response: HTTPURLResponse?, error: Error?) {
        let semaphore = DispatchSemaphore(value: 0)
        
        var result:(data: Data?, response: HTTPURLResponse?, error: Error?)
        dataTask(with: request){ serverResult in
            result.data = serverResult.0
            result.response = serverResult.1 as? HTTPURLResponse
            result.error = serverResult.2

            semaphore.signal()
        }.resume()
        
        let _ = semaphore.wait(timeout: .now() + DefaultTimeoutLengthInSeconds)

        return result
    }
    
    func run(_ url: URL) -> (data: Data?, response: HTTPURLResponse?, error: Error?){
        return run(URLRequest(url: url))
    }
    
    func run(_ urlString: String) -> (data: Data?, response: HTTPURLResponse?, error: Error?){
        return run(URL(string: urlString)!)
    }
}
