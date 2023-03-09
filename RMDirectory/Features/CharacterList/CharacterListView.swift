//
//  ContentView.swift
//  RMDirectory
//
//  Created by Marc Basquens on 3/9/23.
//

import SwiftUI

struct CharacterListView: View {
    @StateObject var viewModel = ViewModel()
    @State private var showSheet = false

    var body: some View {
        ZStack {
            List {
                if viewModel.characterList.isEmpty {
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
                    Color.themeTertiary
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
            .searchable(text: $viewModel.filterState.searchText)
            .navigationDestination(for: Character.self) { character in
                CharacterDetailView(character: character)
            }
            .navigationBarTitle(String.title.localize)
            .onAppear {
                viewModel.loadCharacters()
            }
            .sheet(isPresented: $showSheet) {
                FilterView()
                    .environmentObject(viewModel)
                    .presentationDetents([.medium, .height(250)])
                    .presentationDragIndicator(.visible)
            }
            .toolbar {
                Button(String.filter.localize) {
                    showSheet.toggle()
                }
            }
            .alert(String.error.localize, isPresented: $viewModel.loadingError) {
                Button("OK", role: .cancel) {}
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
        CharacterListView()
    }
}
