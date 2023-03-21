//
//  CharacterListAssembler.swift
//  RMDirectory
//
//  Created by user233389 on 3/21/23.
//

import Foundation
import SwiftUI

protocol CharacterListFactoring {
    associatedtype SomeView: View
    static func resolveView(dataRepository: DataRepositoring) -> SomeView
}

protocol CharacterListViewing: View {}

@MainActor
protocol CharacterListViewModelling: ObservableObject {
    var isListEmpty: Bool { get }
    var isLoading: Bool { get set }
    var loadingError: Bool { get set }
    var characterList: [Character] { get set }
    var filterData: [FilterData] { get }
    var searchText: String { get set }
    
    func loadNext() 
    func loadCharacters(loadNext: Bool)
    func updateFilter(newFilter: Filter, newValue: FilterOption)
}

struct CharacterListFactory: CharacterListFactoring {
    
    let dataRepository = DataRepository()

    static func resolveView(dataRepository: DataRepositoring) -> some CharacterListViewing {
        let viewModel = CharacterListViewModel(dataRepository: dataRepository)
        return CharacterListView(viewModel: viewModel)
    }
}
