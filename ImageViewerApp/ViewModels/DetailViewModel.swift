//
//  DetailViewModel.swift
//  ImageViewerApp
//
//  Created by Kuntulu Ankita on 18/04/25.
//

import Foundation
import Photos
import UIKit

class DetailViewModel: ObservableObject {
    @Published var isFavorite: Bool = false
    @Published var isDownloaded: Bool = false

    private let image: UnsplashImageModel
    private let realmManager = RealmManager()

    init(image: UnsplashImageModel) {
        self.image = image
        self.isFavorite = realmManager.isFavorited(image.id)
    }

    func toggleFavorite() {
        if isFavorite {
            realmManager.removeFavorite(with: image.id)
        } else {
            realmManager.addFavorite(from: image)
        }
        isFavorite.toggle()
    }

    func downloadImage() {
        guard let url = URL(string: image.urls.regular) else { return }
        checkPhotoPermission {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data, let uiImage = UIImage(data: data) {
                    UIImageWriteToSavedPhotosAlbum(uiImage, nil, nil, nil)
                    DispatchQueue.main.async {
                        self.isDownloaded = true
                    }
                }
            }.resume()
        }
    }

    private func checkPhotoPermission(completion: @escaping () -> Void) {
        let status = PHPhotoLibrary.authorizationStatus(for: .addOnly)
        switch status {
        case .authorized, .limited:
            completion()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .addOnly) { newStatus in
                if newStatus == .authorized || newStatus == .limited {
                    DispatchQueue.main.async { completion() }
                }
            }
        default:
            break
        }
    }
}

