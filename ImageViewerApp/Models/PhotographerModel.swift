//
//  Photographer.swift
//  ImageViewerApp
//
//  Created by Kuntulu Ankita on 17/04/25.
//

import Foundation

struct PhotographerModel: Decodable {
    let name: String
    let username: String
    let profileImage: ProfileImage
    
    enum CodingKeys: String, CodingKey {
        case name
        case username
        case profileImage = "profile_image"
    }
}

struct ProfileImage: Decodable {
    let small: String
}

