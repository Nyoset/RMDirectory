//
//  CharacterDetailCell.swift
//  RMDirectory
//
//  Created by Marc Basquens on 3/14/23.
//

import Foundation

enum CharacterDetailCellType {
    case summary
    case location
    case origin
    case status
    case episodes
}

struct CharacterDetailCell {
    var type: CharacterDetailCellType
    var data: String
}
