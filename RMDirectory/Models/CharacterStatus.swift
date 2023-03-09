//
//  CharacterStatus.swift
//  RMDirectory
//
//  Created by Marc Basquens on 3/14/23.
//

import Foundation

enum CharacterStatus: String, RawRepresentable, Codable, CaseIterable  {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}
