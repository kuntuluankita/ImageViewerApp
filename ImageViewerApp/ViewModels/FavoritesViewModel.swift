//
//  FavoritesViewModel.swift
//  ImageViewerApp
//
//  Created by Kuntulu Ankita on 18/04/25.
//

import Foundation
import RealmSwift
import Combine

class FavoritesViewModel: ObservableObject {
    @Published var favoriteImages: [FavoriteImage] = []
    
    private var realmManager = RealmManager()
    private var token: NotificationToken?

    init() {
        fetchFavorites()
    }

    private func fetchFavorites() {
        let results = realmManager.fetchFavorites()
        token = results.observe { [weak self] _ in
            self?.favoriteImages = Array(results)
        }
    }

//    func delete(at offsets: IndexSet) {
//        for index in offsets {
//            let image = favoriteImages[index]
//            realmManager.removeFavorite(with: image.id)
//        }
//        fetchFavorites()
//    }
    
    func deleteImages(with ids: [String]) {
        for id in ids {
            realmManager.removeFavorite(with: id)
        }
        fetchFavorites()
    }
    
    deinit {
        token?.invalidate()
    }
}

