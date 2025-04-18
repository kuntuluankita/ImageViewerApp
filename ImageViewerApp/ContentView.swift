//
//  ContentView.swift
//  ImageViewerApp
//
//  Created by Kuntulu Ankita on 18/04/25.
//

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
                .onChange(of: isDarkMode) { newValue in
                    // Handle dark mode change
                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
                        if let window = windowScene.windows.first {
                            window.overrideUserInterfaceStyle = newValue ? .dark : .light
                        }
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
