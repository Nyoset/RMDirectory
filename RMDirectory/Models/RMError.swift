//
//  RMError.swift
//  RMDirectory
//
//  Created by Marc Basquens on 3/14/23.
//

import Foundation

enum RMError: Error {
    case noResults
    case generic
    case decoding
    case request
    case endOfResults
}
