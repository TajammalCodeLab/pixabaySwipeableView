//
//  HomeVM.swift
//  pixabay
//
//  Created by Ml bench-iOS Dev on 12/23/25.
//

import Foundation

@Observable
class HomeVM {
  var isLoading = false
  var alertMessage = ""
  var showAlert = false
  var images = PixabayResponse()
}

extension HomeVM: NetworkManagerService {
  @MainActor
  func getImages() async {
    isLoading = true
    defer { isLoading = false }
    let endpoint: GetImagesEndPoints = .fetchImages(page: "15", imageType: "cars")
    let response = await sendRequest(endpoint: endpoint, responseModel: PixabayResponse.self)
    switch response {
    case .success(let data):
      self.images = data
    case .failure(let error):
      print(error.localizedDescription)
      showAlert(error.localizedDescription)
    }
  }
  
  private func showAlert(_ message: String) {
    showAlert = true
    alertMessage = message
  }
}
