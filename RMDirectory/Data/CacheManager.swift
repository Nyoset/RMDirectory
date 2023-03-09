//
//  CacheManager.swift
//  RMDirectory
//
//  Created by Marc Basquens on 3/11/23.
//

import Foundation

class CacheManager {
    private var cache = NSCache<NSString, NSData>()
        
    func getCache<T: Codable>(key: String) -> T? {
        guard let cache = cache.object(forKey: key.asCache) else { return nil }
        return try? JSONDecoder().decode(T.self, from: cache as Data)
    }
        
    func saveCache<T: Codable>(key: String, data: T) {
        do {
            try cache.setObject(JSONEncoder().encode(data) as NSData, forKey: key.asCache)
        } catch {
            print("There was an error caching!")
        }
    }
}

extension String {
    var asCache: NSString {
        "cache_\(self)" as NSString
    }
}
