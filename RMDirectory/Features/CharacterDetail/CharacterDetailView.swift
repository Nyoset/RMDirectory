//
//  CharacterDetailView.swift
//  RMDirectory
//
//  Created by Marc Basquens on 3/10/23.
//

import SwiftUI

struct CharacterDetailView: View {
    @ObservedObject var viewModel: ViewModel
    
    init(character: Character) {
        self.viewModel = ViewModel(character: character)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(
                url: viewModel.imageUrl,
                content: { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                },
                placeholder: {
                    Image(ImageData.placeholder)
                }
            )

            ForEach(viewModel.cells, id: \.self.type) { cell in
                buildCell(type: cell.type, value: cell.data)
                Divider()
            }
            Spacer()
        }
        .navigationTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func icon(type: CharacterDetailCellType) -> String {
        switch type {
        case .summary:
            return ImageData.character
        case .location:
            return ImageData.location
        case .origin:
            return ImageData.origin
        case .status:
            return ImageData.status
        case .episodes:
            return ImageData.episodes
        }
    }
    
    func buildCell(type: CharacterDetailCellType, value: String) -> some View {
        return HStack {
            Image(systemName: icon(type: type))
                .resizable()
                .frame(width: 32, height: 32)
                .padding([.leading])
            Text(value)
                .padding([.leading])
        }
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        if let character = Bundle.main.decode(Character.self, from: "characterExample.json") {
            CharacterDetailView(character: character)
        }
    }
}
