//
//  UnsplashImage.swift
//  ImageViewerApp
//
//  Created by Kuntulu Ankita on 17/04/25.
//

import Foundation

struct UnsplashImageModel: Decodable, Identifiable {
    let id: String
    let urls: ImageURLs
    let user: PhotographerModel
}

struct ImageURLs: Decodable {
    let small: String
    let regular: String
}

