//
//  Character.swift
//  RMDirectory
//
//  Created by Marc Basquens on 3/9/23.
//

import Foundation

struct Character: Codable, Identifiable, Hashable {
    var id: Int
    var name: String
    var status: CharacterStatus
    var species: String
    var type: String
    var gender: CharacterGender
    var origin: Location
    var location: Location
    var image: String
    var episode: [String]
    var url: String
    var created: String
    
    var imageURL: URL? {
        URL(string: image)
    }
}
