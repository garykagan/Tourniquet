//
//  File.swift
//  
//
//  Created by Gary Kagan on 10/10/22.
//

import Foundation

class CodableStorage {
    func set(value: Codable?, for key: String) {
        guard let value = value else {
            UserDefaults.standard.removeObject(forKey: key)
            return
        }
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(value) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
    
    func get<T: Decodable>(for key: String) -> T? {
        guard let data = UserDefaults.standard.object(forKey: key) as? Data else { return nil }
        
        let decoder = JSONDecoder()
        guard let value = try? decoder.decode(T.self, from: data) else {
            return nil
        }
        return value
    }
}
