//
//  NetworkManager.swift
//  RMDirectory
//
//  Created by Marc Basquens on 3/9/23.
//

import Foundation

class NetworkManager {
    static func call<T: Codable>(request: URLRequest) async -> Result<T, RMError> {
        guard let (data, response) = try? await URLSession.shared.data(for: request) else { return .failure(.request) }
        guard let httpResponse = response as? HTTPURLResponse else { return .failure(.request) }
        if httpResponse.statusCode == 404 {
            return .failure(.noResults)
        }
        guard let decodedData = try? JSONDecoder().decode(T.self, from: data) else { return .failure(.decoding) }
        
        return .success(decodedData)
    }
}
