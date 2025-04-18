//
//  HomeView.swift
//  ImageViewerApp
//
//  Created by Kuntulu Ankita on 18/04/25.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            Group {
                if viewModel.isLoading && viewModel.images.isEmpty {
                    ProgressView("Loading...")
                } else if let error = viewModel.errorMessage {
                    Text("Error: \(error)")
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(Array(viewModel.images.enumerated()), id: \.1.id) { index, image in
                                NavigationLink(destination: DetailView(image: image)) {
                                    ImageCell(image: image)
                                        .onAppear {
                                            if index == viewModel.images.count - 1 {
                                                viewModel.fetchImages()
                                            }
                                        }
                                }
                            }
                        }
                        .padding()
                        
                        if viewModel.isLoading {
                            ProgressView()
                                .padding()
                        }
                    }
                }
            }
            .navigationTitle("Gallery")
            .onAppear {
                viewModel.fetchImages()
            }
        }
    }
}


#Preview {
    HomeView()
}
