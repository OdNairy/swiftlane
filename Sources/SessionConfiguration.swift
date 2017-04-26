//
//  SessionConfiguration.swift
//  swiftlane
//
//  Created by Roman Gardukevich on 4/25/17.
//
//

import Foundation
import Socks
import SocksCore

extension URLSessionConfiguration {
    func useProxyIfAvailable(host: String = "127.0.0.1", port: UInt16 = 8888){
        func proxyAvailable() -> Bool {
            do{
                let socket = try TCPInternetSocket(address: InternetAddress(hostname: host, port: port, addressFamily: .inet))
                try socket.connect()
                try socket.close()
            } catch {
                debugPrint(error)
                return false
            }
            return true
        }
        let useProxy = proxyAvailable()
        debugPrint("Should use proxy = \(useProxy)")
        
        self.connectionProxyDictionary = [
            kCFNetworkProxiesHTTPEnable as AnyHashable : useProxy,
            kCFNetworkProxiesHTTPSEnable as AnyHashable : useProxy,
            kCFStreamPropertyHTTPProxyPort as AnyHashable : port,
            kCFStreamPropertyHTTPSProxyPort as AnyHashable: port,
            kCFStreamPropertyHTTPProxyHost as AnyHashable : host,
            kCFStreamPropertyHTTPSProxyHost as AnyHashable: host,
        ]
    }
}
