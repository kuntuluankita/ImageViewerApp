//
//  UnsplashService.swift
//  ImageViewerApp
//
//  Created by Kuntulu Ankita on 17/04/25.
//

import Foundation
import Combine

class UnsplashService {
    private let baseURL = "https://api.unsplash.com"
    private let accessKey = "DzQ7FX49fu0pX_s7fzrEMLqHQYH3Al-ZIr5L5LgQtk0"
    
    private let perPage = 20

    func fetchImages(page: Int = 1) -> AnyPublisher<[UnsplashImageModel], Error> {
        guard let url = URL(string: "\(baseURL)/photos?page=\(page)&per_page=\(perPage)&client_id=\(accessKey)") else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: [UnsplashImageModel].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
}
