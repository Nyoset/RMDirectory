//
//  DataRepository.swift
//  RMDirectory
//
//  Created by Marc Basquens on 3/11/23.
//

import Foundation

protocol DataRepositoring {
    func getCharacters(filters: [Filter], forceNext: Bool) async -> Result<[Character], RMError>
}

class DataRepository: DataRepositoring {
    static var instance: DataRepository = {
        return DataRepository()
    }()
    
    private var cacheManager = CacheManager()
    private var paginationData = [[Filter] : ApiResponseInfo]()
    
    func getCharacters(filters: [Filter] = [], forceNext: Bool = false) async -> Result<[Character], RMError> {
        if !forceNext, let cachedResult: [Character] = cacheManager.getCache(key: filters.query) {
            return .success(cachedResult)
        }
        let result = await APIRouter.getCharacters(filters: filters, paginationData: forceNext ? paginationData[filters] : nil)
        switch result {
        case .success(let response):
            paginationData[filters] = response.info
            var charactersResult: [Character] = cacheManager.getCache(key: filters.query) ?? []
            charactersResult.append(contentsOf: response.results)
            cacheManager.saveCache(key: filters.query, data: charactersResult)
            return .success(charactersResult)
        case .failure(let error):
            return .failure(error)
        }
    }
}
