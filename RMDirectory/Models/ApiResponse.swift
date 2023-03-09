//
//  ApiResponse.swift
//  RMDirectory
//
//  Created by Marc Basquens on 3/10/23.
//

import Foundation

struct ApiResponse<T: Codable>: Codable {
    var info: ApiResponseInfo
    var results: T
}

typealias CharactersResponse = ApiResponse<[Character]>
