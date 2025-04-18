//
//  DetailView.swift
//  ImageViewerApp
//
//  Created by Kuntulu Ankita on 18/04/25.
//

import SwiftUI

struct DetailView: View {
    let image: UnsplashImageModel
    @StateObject private var viewModel: DetailViewModel

    init(image: UnsplashImageModel) {
        self.image = image
        _viewModel = StateObject(wrappedValue: DetailViewModel(image: image))
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 16) {
                AsyncImage(url: URL(string: image.urls.regular)) { phase in
                    switch phase {
                    case .empty:
                        Color.gray
                            .frame(height: 300)
                            .shimmer()
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                    case .failure:
                        Color.gray.frame(height: 300)
                    @unknown default:
                        EmptyView()
                    }
                }

                HStack(spacing: 12) {
                    AsyncImage(url: URL(string: image.user.profileImage.small)) { phase in
                        switch phase {
                        case .empty:
                            Circle()
                                .fill(Color.gray)
                                .frame(width: 40, height: 40)
                                .shimmer()
                        case .success(let image):
                            image
                                .resizable()
                                .frame(width: 40, height: 40)
                                .clipShape(Circle())
                        case .failure:
                            Image(systemName: "person.crop.circle.badge.exclamationmark")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.gray)
                        @unknown default:
                            EmptyView()
                        }
                    }

                    VStack(alignment: .leading) {
                        Text(image.user.name)
                            .font(.headline)
                        Text("@\(image.user.username)")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding(.horizontal)

                HStack(spacing: 24) {
                    Button(action: {
                        viewModel.downloadImage()
                    }) {
                        if viewModel.isDownloaded {
                            Label("Downloaded", systemImage: "checkmark.circle")
                        } else {
                            Label("Download", systemImage: "arrow.down.circle")
                        }
                    }
                    .disabled(viewModel.isDownloaded)


                    Button(action: {
                        viewModel.toggleFavorite()
                    }) {
                        Label(viewModel.isFavorite ? "Unfavorite" : "Favorite",
                              systemImage: viewModel.isFavorite ? "heart.fill" : "heart")
                    }
                }
                .padding()
                .buttonStyle(.borderedProminent)
            }
            .padding()
        }
        .navigationTitle("Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

