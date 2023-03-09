//
//  FilterView.swift
//  RMDirectory
//
//  Created by Marc Basquens on 3/13/23.
//

import SwiftUI

struct FilterView: View {
    @EnvironmentObject var viewModel: CharacterListView.ViewModel
    
    var body: some View {
        VStack {
            Text(String.filterBy.localize)
            ForEach(viewModel.filterData, id: \.self.type) { filterData in
                filterSet(icon: getIcon(type: filterData.type), options: filterData.options) {
                    viewModel.updateFilter(newFilter: filterData.type, newValue: $0)
                }
            }
            Spacer()
        }
        .padding([.top])
    }
    
    func getIcon(type: Filter) -> String {
        switch type {
        case .gender(_):
            return ImageData.character
        case .status(_):
            return ImageData.status
        default:
            return ImageData.origin
        }
    }
    
    func filterSet(icon: String, options: [FilterOption], onTap: @escaping (FilterOption) -> ()) -> some View {
        return HStack {
            Image(systemName: icon)
                .resizable()
                .frame(width: 32, height: 32)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: [GridItem(.flexible(minimum: 50))]) {
                    ForEach(options, id: \.self.label) { option in
                        getCell(text: option.label.capitalized, active: option.active)
                            .onTapGesture { onTap(option) }
                    }
                }
            }
        }
        .padding()
    }
    
    func getCell(text: String, active: Bool) -> some View {
        Text(text)
            .padding(7)
            .background(
                (active ? Color.themeTertiary : Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.themeTertiary, lineWidth: 2)
            )
            .padding([.leading], 2)
    }
}

struct FilterView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyView()
    }
}
