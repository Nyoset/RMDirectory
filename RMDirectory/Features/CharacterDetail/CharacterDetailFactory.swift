//
//  CharacterListAssembler.swift
//  RMDirectory
//
//  Created by user233389 on 3/21/23.
//

import Foundation
import SwiftUI

protocol CharacterDetailFactoring {
    associatedtype SomeView: View
    static func resolveView(character: Character) -> SomeView
}

protocol CharacterDetailViewing: View {}

@MainActor
protocol CharacterDetailViewModelling: ObservableObject {
    var title: String { get }
    var cells: [CharacterDetailCell] { get set }
    var imageUrl: URL? { get }
}

struct CharacterDetailFactory: CharacterDetailFactoring {
    
    let dataRepository = DataRepository()

    @MainActor static func resolveView(character: Character) -> some CharacterDetailViewing {
        let viewModel = CharacterDetailViewModel(character: character)
        return CharacterDetailView(viewModel: viewModel)
    }
}
