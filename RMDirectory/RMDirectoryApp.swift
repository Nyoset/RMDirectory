//
//  RMDirectoryApp.swift
//  RMDirectory
//
//  Created by Marc Basquens on 3/9/23.
//

import SwiftUI

@main
struct RMDirectoryApp: App {
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                CharacterListView()
                .navigationBarTitleDisplayMode(.large)
            }
        }
    }
}
