//
//  Strings.swift
//  RMDirectory
//
//  Created by Marc Basquens on 3/11/23.
//

import Foundation

extension String {
    var localize: String {
        NSLocalizedString(self, comment: "")
    }
    func localize(_ params: CVarArg...) -> String {
        String(format: NSLocalizedString(self, comment: ""), params)
    }
    
    static let title = "title"
    static let noResults = "noResults"
    static let filter = "filter"
    static let filterBy = "filterBy"
    static let appeared = "appeared"
    static let error = "error"
}
