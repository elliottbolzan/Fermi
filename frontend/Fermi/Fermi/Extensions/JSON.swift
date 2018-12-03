//
//  JSON.swift
//  Fermi
//
//  Created by Elliott Bolzan on 11/22/18.
//  Copyright © 2018 Davis Booth. All rights reserved.
//

import Foundation

extension Encodable {
    
    func toJSON() -> [String: Any] {
        let encoder = JSONEncoder()
        let data = try! encoder.encode(self)
        return try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
    }
    
}

extension Decodable {
    
    static func from(json: String) -> Self {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let data = json.data(using: .utf8)!
        return try! decoder.decode(Self.self, from: data)
    }
    
}
