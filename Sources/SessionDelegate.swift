//
//  SessionDelegate.swift
//  swiftlane
//
//  Created by Roman Gardukevich on 28/11/16.
//
//

import Foundation

class SessionDelegate : NSObject, URLSessionTaskDelegate {
    func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        completionHandler(nil)
    }
}
