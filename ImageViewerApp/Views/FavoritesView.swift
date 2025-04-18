//
//  SwiftUIView.swift
//  ImageViewerApp
//
//  Created by Kuntulu Ankita on 18/04/25.
//

import SwiftUI

struct FavoritesView: View {
    @StateObject private var viewModel = FavoritesViewModel()

    var body: some View {
        NavigationView {
            Group {
                if viewModel.favoriteImages.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "heart.slash")
                            .font(.system(size: 48))
                            .foregroundColor(.gray)
                        Text("No Favorites Yet")
                            .foregroundColor(.gray)
                    }
                } else {
                    List {
                        ForEach(viewModel.favoriteImages, id: \.id) { image in
                            VStack(alignment: .leading) {
                                AsyncImage(url: URL(string: image.imageUrl)) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(height: 150)
                                    case .success(let img):
                                        img
                                            .resizable()
                                            .scaledToFill()
                                            .frame(height: 150)
                                            .clipped()
                                            .cornerRadius(10)
                                    case .failure:
                                        Color.gray.frame(height: 150)
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                Text(image.photographerName)
                                    .font(.caption)
                                    .padding(.horizontal, 4)
                            }
                            .background(
                                NavigationLink(
                                    destination: getDetailView(for: image)
                                ) {
                                    EmptyView()
                                }
                                .opacity(0) // Hide the link's default appearance
                            )
                        }
                        .onDelete { indexSet in
                            // Capture IDs before deleting from Realm to avoid invalid access
                            let idsToDelete = indexSet.map { viewModel.favoriteImages[$0].id }
                            viewModel.deleteImages(with: idsToDelete)

                            // Remove from the view model's list to prevent invalid access in the UI
                            viewModel.favoriteImages.remove(atOffsets: indexSet)
                        }
                    }
                }
            }
            .navigationTitle("Favorites")
            .toolbar {
                EditButton()
            }
        }
    }

    private func getDetailView(for image: FavoriteImage) -> some View {
        let unsplashImage = image.toUnsplashImage() ?? UnsplashImageModel(id: "", urls: ImageURLs(small: "", regular: ""), user: PhotographerModel(name: "", username: "", profileImage: ProfileImage(small: "")))
        return DetailView(image: unsplashImage)
    }
}

#Preview {
    FavoritesView()
}
