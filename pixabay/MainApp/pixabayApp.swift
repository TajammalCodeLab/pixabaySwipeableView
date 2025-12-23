//
//  pixabayApp.swift
//  pixabay
//
//  Created by SID on 23/12/2025.
//

import SwiftUI

@main
struct pixabayApp: App {
  @State var vm: HomeVM = .init()
    var body: some Scene {
        WindowGroup {
            NavigationStack{
              HomeView(viewModel: vm)
            }
        }
    }
}
