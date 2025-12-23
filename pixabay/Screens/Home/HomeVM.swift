//
//  HomeVM.swift
//  pixabay
//
//  Created by Ml bench-iOS Dev on 12/23/25.
//

import Foundation

@Observable
class HomeVM {

    private let repository: ImageRepositoryProtocol

    var isLoading = false
    var alertMessage = ""
    var showAlert = false
    var images = PixabayResponse()

    init(repository: ImageRepositoryProtocol = ImageRepository()) {
        self.repository = repository
    }

    @MainActor
    func getImages() async {
        isLoading = true
        defer { isLoading = false }

        do {
            let hits = try await repository.loadImages()
            images.hits = hits
        } catch {
            showAlert(error.localizedDescription)
        }
    }

    private func showAlert(_ message: String) {
        showAlert = true
        alertMessage = message
    }
}
