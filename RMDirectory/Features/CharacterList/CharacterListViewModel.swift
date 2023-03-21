//
//  CharacterListViewModel.swift
//  RMDirectory
//
//  Created by Marc Basquens on 3/9/23.
//

import Foundation

struct FilterOption {
    var label: String
    var active: Bool
}

struct FilterData {
    var type: Filter
    var options: [FilterOption]
}

@MainActor class CharacterListViewModel: CharacterListViewModelling {
  
    let dataRepository: DataRepositoring
    
    @Published var isLoading = false
    @Published var loadingError = false
    @Published var characterList = [Character]()
    var isListEmpty: Bool {
        characterList.isEmpty
    }
    @Published var filterState = FilterState() {
        didSet {
            loadCharacters()
        }
    }
    private var filters: [Filter] {
        var result = [Filter]()
        if !filterState.searchText.isEmpty {
            result.append(.name(filterState.searchText))
        }
        if let gender = filterState.gender {
            result.append(.gender(gender))
        }
        if let status = filterState.status {
            result.append(.status(status))
        }
        return result
    }
    var searchText: String {
        get { filterState.searchText }
        set { filterState.searchText = newValue }
    }
    var task: Task<Void, Never>?
    
    var filterData: [FilterData] {
         [
            FilterData(type: .gender(.unknown), options: CharacterGender.allCases.map { FilterOption(label: $0.rawValue, active: $0 == filterState.gender) }),
            FilterData(type: .status(.unknown), options: CharacterStatus.allCases.map { FilterOption(label: $0.rawValue, active: $0 == filterState.status) }),
        ]
    }
    
    nonisolated init(dataRepository: DataRepositoring) {
        self.dataRepository = dataRepository
    }
    
    func updateFilter(newFilter: Filter, newValue: FilterOption) {
        if case .gender(_) = newFilter {
            let newGender = CharacterGender(rawValue: newValue.label)
            if filterState.gender == newGender {
                filterState.gender = nil
            } else {
                filterState.gender = newGender
            }
        } else if case .status(_) = newFilter {
            let newStatus = CharacterStatus(rawValue: newValue.label)
            if filterState.status == newStatus {
                filterState.status = nil
            } else {
                filterState.status = newStatus
            }
        }
    }

    func loadCharacters(loadNext: Bool = false) {
        task?.cancel()
        task = Task {
            isLoading = true
            let result = await dataRepository.getCharacters(filters: filters, forceNext: loadNext)
            isLoading = false
            switch result {
            case .success(let characters):
                characterList = characters
            case .failure(let error):
                if case .noResults = error {
                    characterList = []
                } else if case .endOfResults = error {}
                else if !Task.isCancelled {
                    loadingError = true
                } else {
                    isLoading = true
                }
            }
        }
    }
    
    func loadNext() {
        if !characterList.isEmpty && !isLoading {
            loadCharacters(loadNext: true)
        }
    }
}

