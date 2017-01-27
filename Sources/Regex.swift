//
//  Regex.swift
//  swiftlane
//
//  Created by Roman Gardukevich on 30/10/16.
//
//

import Foundation


extension String {
    
    func matches(_ regex: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let nsString = self as NSString
            let results = regex.matches(in: self, range: NSRange(location: 0, length: nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
}
