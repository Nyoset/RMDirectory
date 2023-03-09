//
//  Filter.swift
//  RMDirectory
//
//  Created by Marc Basquens on 3/11/23.
//

import Foundation

enum Filter: Hashable {
    case name(String)
    case gender(CharacterGender)
    case status(CharacterStatus)
    
    var query: String {
        switch self {
        case .name(let name):
            return name.isEmpty ? "" : "name=\(name.replacingOccurrences(of: " ", with: "%20"))"
        case .gender(let gender):
            return "gender=\(gender.rawValue)"
        case .status(let status):
            return "status=\(status.rawValue)"
        }
    }
        
    func isOfType(filter: Filter) -> Bool {
        switch (self, filter) {
        case (.name, .name), (.gender, .gender), (.status, .status):
            return true
        default:
            return false
        }
    }
}

extension [Filter] {
    var query: String {
        String(reduce("?", { "\($0)\($1.query)&" }).dropLast())
    }
}
