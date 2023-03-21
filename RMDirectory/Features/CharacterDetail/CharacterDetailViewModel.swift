//
//  CharacterDetailViewModel.swift
//  RMDirectory
//
//  Created by Marc Basquens on 3/13/23.
//

import Foundation

@MainActor class CharacterDetailViewModel: CharacterDetailViewModelling {
    private var unknown = "unknown"
    private let character: Character
    @Published var cells = [CharacterDetailCell]()
    
    
    var characterSummary: String {
        var result = ""
        if character.gender != .unknown {
            result.append(character.gender.rawValue)
        }
        if character.species != unknown && !character.type.contains(character.species) {
            result.append(" \(character.species)")
        }
        if !character.type.isEmpty {
            result.append(" \(character.type)")
        }
        return result
    }
    var episodeCount: String {
        String.appeared.localize(String(character.episode.count)) + (character.episode.count > 1 ? "s" : "")
    }
    var imageUrl: URL? {
        character.imageURL
    }
    var title: String {
        character.name
    }
    
    init(character: Character) {
        self.character = character
        cells = [
            CharacterDetailCell(type: .summary, data: characterSummary),
            CharacterDetailCell(type: .location, data: character.location.name.capitalized),
            CharacterDetailCell(type: .origin, data: character.origin.name.capitalized),
            CharacterDetailCell(type: .status, data: character.status.rawValue.capitalized),
            CharacterDetailCell(type: .episodes, data: episodeCount)
        ]
    }
}
