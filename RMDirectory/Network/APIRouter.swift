//
//  APIManager.swift
//  RMDirectory
//
//  Created by Marc Basquens on 3/9/23.
//

import Foundation

class APIRouter {
    private static let baseURL = "https://rickandmortyapi.com/api/"
    
    enum Endpoint {
        case characters([Filter] = [])
        
        var path: String {
            switch self {
            case .characters(let filters):
                return "character\(filters.query)"
            }
        }
        
        var method: String {
            return "GET"
        }
    }
    
    private static func buildRequest(endpoint: Endpoint) -> URLRequest? {
        guard let url = URL(string: "\(baseURL)\(endpoint.path)") else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        return request
    }
    
    private static func buildRequest(metadata: ApiResponseInfo) -> URLRequest? {
        guard let urlString = metadata.next, let url = URL(string: urlString) else { return nil }
        return URLRequest(url: url)
    }
    
    static func getCharacters(filters: [Filter], metadata: ApiResponseInfo? = nil) async -> Result<CharactersResponse, RMError> {
        let request: URLRequest? = {
            if let metadata = metadata {
                return buildRequest(metadata: metadata)
            } else {
                return buildRequest(endpoint: .characters(filters))
            }
        }()
        guard let request = request else { return .failure(.endOfResults) }
        return await NetworkManager.shared.call(request: request)
    }
}
