//
//  ImageRepository.swift
//  pixabay
//
//  Created by Ml bench-iOS Dev on 12/23/25.
//
import Foundation
import CoreData

protocol ImageRepositoryProtocol {
  func loadImages() async throws -> [PixabayImage]
}

final class ImageRepository: ImageRepositoryProtocol, NetworkManagerService {
  
  private let context = CoreDataManager.shared.context
  
  func loadImages() async throws -> [PixabayImage] {
    let localImages = fetchFromCoreData()
    if !localImages.isEmpty {
      return localImages
    }
    let endpoint: GetImagesEndPoints = .fetchImages(page: "15", imageType: "cars")
    let response = await sendRequest(endpoint: endpoint, responseModel: PixabayResponse.self)
    
    switch response {
    case .success(let data):
      saveToCoreData(data.hits)
      return data.hits
      
    case .failure(let error):
      throw error
    }
  }
  private func saveToCoreData(_ hits: [PixabayImage]) {
    hits.forEach { hit in
      let cdImage = PixabayEntity(context: context)
      cdImage.id = Int32(hit.id)
      cdImage.downloads = Int32(hit.downloads)
      cdImage.height = Double(hit.imageHeight)
      cdImage.id = Int32(hit.id)
      cdImage.imageUrl = hit.largeImageURL
      cdImage.likes = Int32(hit.likes)
      cdImage.tags = hit.tags
      cdImage.width = Double(hit.imageWidth)
      cdImage.userName = hit.user
    }
    CoreDataManager.shared.save()
  }
  private func fetchFromCoreData() -> [PixabayImage] {
    let request: NSFetchRequest<PixabayEntity> = PixabayEntity.fetchRequest()
    
    let results = (try? context.fetch(request)) ?? []
    
    return results.map {
      PixabayImage(id: Int($0.id), pageURL: "", type: "", tags: $0.tags, previewURL: "", previewWidth: 0, previewHeight: 0, webformatURL: "", webformatWidth: 1, webformatHeight: 1, largeImageURL: $0.imageUrl, imageWidth: Int($0.width), imageHeight: Int($0.height), imageSize: 0, views: 1, downloads: Int($0.downloads), collections: 0, likes: 0, comments: 0, userID: 0, user: $0.userName, userImageURL: "", userURL: "", noAiTraining: true, isAiGenerated: false, isGRated: false, isLowQuality: false)
      
    }
  }
  
}
