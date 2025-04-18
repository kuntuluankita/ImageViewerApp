//
//  RealmManager.swift
//  ImageViewerApp
//
//  Created by Kuntulu Ankita on 17/04/25.
//

import Foundation
import RealmSwift

class RealmManager {
    private var realm: Realm

    init() {
        realm = try! Realm()
    }

    func addFavorite(from image: UnsplashImageModel) {
        let favorite = FavoriteImage()
        favorite.id = image.id
        favorite.imageUrl = image.urls.regular
        favorite.photographerName = image.user.name
        favorite.username = image.user.username
        favorite.profileImageUrl = image.user.profileImage.small

        try? realm.write {
            realm.add(favorite, update: .modified)
        }
    }

    func removeFavorite(with id: String) {
        if let image = realm.object(ofType: FavoriteImage.self, forPrimaryKey: id) {
            try? realm.write {
                realm.delete(image)
            }
        }
    }

    func isFavorited(_ id: String) -> Bool {
        realm.object(ofType: FavoriteImage.self, forPrimaryKey: id) != nil
    }

    func fetchFavorites() -> Results<FavoriteImage> {
        realm.objects(FavoriteImage.self)
    }
}

