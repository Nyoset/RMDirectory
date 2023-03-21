//
//  CharacterListAssembler.swift
//  RMDirectory
//
//  Created by user233389 on 3/21/23.
//

import Foundation
import SwiftUI

protocol FilterFactoring {
    static func resolveView(viewModel: CharacterListViewModel) -> any FilterViewing
}

protocol FilterViewing: View {}

@MainActor
protocol FilterViewModelling: ObservableObject {
    
}

struct FilterFactory: FilterFactoring {
    
    @MainActor static func resolveView(viewModel: CharacterListViewModel) -> any FilterViewing {
        return FilterView(viewModel: viewModel)

    }
}
