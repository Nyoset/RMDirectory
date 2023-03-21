//
//  ContentView.swift
//  RMDirectory
//
//  Created by Marc Basquens on 3/9/23.
//

import SwiftUI

struct CharacterListView<ViewModel: CharacterListViewModelling>: CharacterListViewing {
    @StateObject var viewModel: ViewModel
    @State private var showSheet = false

    var body: some View {
        ZStack {
            List {
                if viewModel.isListEmpty {
                    Text(String.noResults.localize)
                }
                ForEach(viewModel.characterList) { character in
                    ZStack {
                        NavigationLink(value: character) {
                            EmptyView()
                        }.opacity(0)
                        CharacterCell(character: character)
                    }
                    .listRowSeparator(.hidden)
                    
                }.listRowBackground(
                    Color.theme
                        .clipped()
                        .cornerRadius(20)
                        .padding([.bottom, .top], 3)
                )
                Color.clear
                    .frame(width: 0, height: 0, alignment: .bottom)
                    .onAppear {
                        viewModel.loadNext()
                    }
            }
            .scrollContentBackground(.hidden)
            .listStyle(.plain)
            .padding()
            .ignoresSafeArea(.all, edges: .bottom)
            .scrollIndicators(.hidden)
            .searchable(text: $viewModel.searchText)
            .navigationDestination(for: Character.self) { character in
                CharacterDetailFactory.resolveView(character: character)
            }
            .navigationBarTitle(String.title.localize)
            .onAppear {
                viewModel.loadCharacters(loadNext: false)
            }
            .sheet(isPresented: $showSheet) {
                FilterView(viewModel: viewModel)
                    .presentationDetents([.medium, .height(250)])
                    .presentationDragIndicator(.visible)
            }
            .toolbar {
                Button(String.filter.localize) {
                    showSheet.toggle()
                }
            }
            .alert(String.error.localize, isPresented: $viewModel.loadingError) {
                Button(String.ok.localize, role: .cancel) {}
            }
            if viewModel.isLoading {
                Color.white.opacity(0.7).ignoresSafeArea()
                ProgressView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let mockDataRepository = MockDataRepository()
        CharacterListFactory.resolveView(dataRepository: mockDataRepository)
    }
}

class MockDataRepository: DataRepositoring {
    func getCharacters(filters: [Filter], forceNext: Bool) async -> Result<[Character], RMError> {
        if let character = Mock.character {
            return .success([character])
        } else {
            return .failure(.decoding)
        }
    }
}
