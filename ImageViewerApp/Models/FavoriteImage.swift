//
//  FavoriteImage.swift
//  ImageViewerApp
//
//  Created by Kuntulu Ankita on 17/04/25.
//

import Foundation
import RealmSwift

class FavoriteImage: Object, Identifiable {
    @Persisted(primaryKey: true) var id: String
    @Persisted var imageUrl: String
    @Persisted var photographerName: String
    @Persisted var username: String
    @Persisted var profileImageUrl: String
}


extension FavoriteImage {
    func toUnsplashImage() -> UnsplashImageModel? {
        return UnsplashImageModel(
            id: self.id,
            urls: ImageURLs(
                small: self.imageUrl,
                regular: self.imageUrl
            ),
            user: PhotographerModel(
                name: self.photographerName,
                username: self.username,
                profileImage: ProfileImage(small: self.profileImageUrl)
            )
        )
    }
}

