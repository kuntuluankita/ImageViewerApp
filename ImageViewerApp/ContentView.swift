//
//  ContentView.swift
//  ImageViewerApp
//
//  Created by Kuntulu Ankita on 18/04/25.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isDarkMode: Bool = false

    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Gallery", systemImage: "photo.on.rectangle")
                }
            
            FavoritesView()
                .tabItem {
                    Label("Favorites", systemImage: "heart.fill")
                }
        }
        .onAppear {
            isDarkMode = colorScheme == .dark
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Toggle(isOn: $isDarkMode) {
                    Text("Dark Mode")
                }
                .onChange(of: isDarkMode) { value in
                    if value {
                        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
                    } else {
                        UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
                    }
                }
                .toggleStyle(SwitchToggleStyle())
            }
        }
    }
}

#Preview {
    ContentView()
}
