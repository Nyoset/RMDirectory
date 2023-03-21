//
//  RMDirectoryApp.swift
//  RMDirectory
//
//  Created by Marc Basquens on 3/9/23.
//

import SwiftUI

@main
struct RMDirectoryApp: App {
    
    var mainView: some CharacterListViewing = CharacterListFactory.resolveView(dataRepository: DataRepository())
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                mainView
                .navigationBarTitleDisplayMode(.large)
            }
        }
    }
}
