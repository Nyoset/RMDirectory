//
//  CharacterCell.swift
//  RMDirectory
//
//  Created by Marc Basquens on 3/9/23.
//

import SwiftUI

struct CharacterCell: View {
    let character: Character
    
    var body: some View {
        HStack {
            imageView
            VStack(alignment: .leading, spacing: 10) {
                Text(character.name)
                    .font(
                        .title2
                        .weight(.bold)
                    )
                Text(character.species)
            }
            .padding([.leading], 10)
            Spacer()
        }
    }
    
    var imageView: some View {
        AsyncImage(
            url: character.imageURL,
            content: { image in
                addRoundBorder(image)
            },
            placeholder: {
                addRoundBorder(Image(ImageData.placeholder))
            }
        )
    }
    
    func addRoundBorder(_ image: Image) -> some View {
        image.resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: 100, maxHeight: 100)
            .clipShape(Circle())
            .overlay(Circle().stroke(.black, lineWidth: 2))
    }
}

struct CharacterCell_Previews: PreviewProvider {
    static var previews: some View {
        if let character = Bundle.main.decode(Character.self, from: "characterExample.json") {
            CharacterCell(character: character)
        }
    }
}
