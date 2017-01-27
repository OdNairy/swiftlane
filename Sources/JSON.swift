//
//  JSON.swift
//  swiftlane
//
//  Created by Roman Gardukevich on 21/11/16.
//
//

import Foundation

protocol JSONConvertible {
    func toJSONData() -> Data?
}

extension JSONConvertible {
    func toJSONData() -> Data? {
        return try? JSONSerialization.data(withJSONObject: self, options: JSONSerialization.WritingOptions.prettyPrinted)
    }
}

extension Dictionary : JSONConvertible {}
extension Array : JSONConvertible {}
extension String : JSONConvertible {}

