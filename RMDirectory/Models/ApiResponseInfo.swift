//
//  ApiResponseInfo.swift
//  RMDirectory
//
//  Created by Marc Basquens on 3/10/23.
//

import Foundation

struct ApiResponseInfo: Codable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}
