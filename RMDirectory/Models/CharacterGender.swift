//
//  CharacterGender.swift
//  RMDirectory
//
//  Created by Marc Basquens on 3/14/23.
//

import Foundation

enum CharacterGender: String, RawRepresentable, Codable, CaseIterable  {
    case male = "Male"
    case female = "Female"
    case genderless = "Genderless"
    case unknown = "unknown"
}
