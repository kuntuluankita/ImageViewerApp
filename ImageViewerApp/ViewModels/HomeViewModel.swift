//
//  HomeViewModel.swift
//  ImageViewerApp
//
//  Created by Kuntulu Ankita on 18/04/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    @Published var images: [UnsplashImageModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1
    private var isFetchingMore = false
    private var canFetchMore = true

    private let service = UnsplashService()

    func fetchImages(reset: Bool = false) {
        guard !isFetchingMore && canFetchMore else { return }

        if reset {
            currentPage = 1
            images = []
            canFetchMore = true
        }

        isLoading = currentPage == 1
        isFetchingMore = true

        service.fetchImages(page: currentPage)
            .sink(receiveCompletion: { [weak self] completion in
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.isFetchingMore = false
                }
                if case .failure(let error) = completion {
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] newImages in
                guard let self = self else { return }
                if newImages.isEmpty {
                    self.canFetchMore = false
                } else {
                    // duplicate removal
                    let existingIDs = Set(self.images.map { $0.id })
                    let uniqueImages = newImages.filter { !existingIDs.contains($0.id) }
                    
                    self.images.append(contentsOf: uniqueImages)
                    self.currentPage += 1
                }
            })
            .store(in: &cancellables)
    }
}


