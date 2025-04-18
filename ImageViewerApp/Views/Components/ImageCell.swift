//
//  ImageCell.swift
//  ImageViewerApp
//
//  Created by Kuntulu Ankita on 18/04/25.
//

import SwiftUI

struct ImageCell: View {
    let image: UnsplashImageModel

    var body: some View {
        VStack(alignment: .leading) {
            AsyncImage(url: URL(string: image.urls.small)) { phase in
                switch phase {
                case .empty:
                    Color.gray
                        .aspectRatio(1, contentMode: .fit)
                        .shimmer()
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .clipped()
                case .failure:
                    Color.gray
                        .aspectRatio(1, contentMode: .fit)
                @unknown default:
                    EmptyView()
                }
            }
            HStack {
                Spacer()
                Text(image.user.name)
                    .font(.caption)
                    .foregroundColor(.primary)
                    .padding(.bottom, 4)
                Spacer()
            }
        }
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}


#Preview {
    ImageCell(image: UnsplashImageModel(id: "", urls: ImageURLs(small: "", regular: ""), user: PhotographerModel(name: "Ankita", username: "ankita", profileImage: ProfileImage(small: ""))))
}
