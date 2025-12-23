//
//  PixabayResponse.swift
//  pixabay
//
//  Created by SID on 23/12/2025.
//

import Foundation

struct PixabayResponse: Codable {
  var total: Int
  var totalHits: Int
  var hits: [PixabayImage]
  
  init() {
    self.total = 0
    self.totalHits = 0
    self.hits = []
  }
  
  // Parameter init
  init(total: Int, totalHits: Int, hits: [PixabayImage]) {
    self.total = total
    self.totalHits = totalHits
    self.hits = hits
  }
}

struct PixabayImage: Codable, Identifiable {
  var id: Int
  var pageURL: String
  var type: String
  var tags: String
  
  var previewURL: String
  var previewWidth: Int
  var previewHeight: Int
  
  var webformatURL: String
  var webformatWidth: Int
  var webformatHeight: Int
  
  var largeImageURL: String
  
  var imageWidth: Int
  var imageHeight: Int
  var imageSize: Int
  
  var views: Int
  var downloads: Int
  var collections: Int
  var likes: Int
  var comments: Int
  
  var userID: Int
  var user: String
  var userImageURL: String
  var userURL: String
  
  var noAiTraining: Bool
  var isAiGenerated: Bool
  var isGRated: Bool
  var isLowQuality: Bool
  
  enum CodingKeys: String, CodingKey {
    case id
    case pageURL
    case type
    case tags
    
    case previewURL
    case previewWidth
    case previewHeight
    
    case webformatURL
    case webformatWidth
    case webformatHeight
    
    case largeImageURL
    
    case imageWidth
    case imageHeight
    case imageSize
    
    case views
    case downloads
    case collections
    case likes
    case comments
    
    case userID = "user_id"
    case user
    case userImageURL
    case userURL
    
    case noAiTraining
    case isAiGenerated
    case isGRated
    case isLowQuality
  }
  
  init() {
    self.id = 0
    self.pageURL = ""
    self.type = ""
    self.tags = ""
    
    self.previewURL = ""
    self.previewWidth = 0
    self.previewHeight = 0
    
    self.webformatURL = ""
    self.webformatWidth = 0
    self.webformatHeight = 0
    
    self.largeImageURL = "https://pixabay.com/get/g6aaa3bacc5f733cfd90b81541bd5bb107cee9098e8947f3e0c51720b96d053758a160cb5d8f89afc3a8ce06baa823b6b04c54e6a0d878a6b3b5a16cd433ae5a7_1280.jpg"
    
    self.imageWidth = 0
    self.imageHeight = 0
    self.imageSize = 0
    
    self.views = 0
    self.downloads = 0
    self.collections = 0
    self.likes = 0
    self.comments = 0
    
    self.userID = 0
    self.user = ""
    self.userImageURL = ""
    self.userURL = ""
    
    self.noAiTraining = false
    self.isAiGenerated = false
    self.isGRated = false
    self.isLowQuality = false
  }
  
  // Parameter init
  init(
    id: Int,
    pageURL: String,
    type: String,
    tags: String,
    previewURL: String,
    previewWidth: Int,
    previewHeight: Int,
    webformatURL: String,
    webformatWidth: Int,
    webformatHeight: Int,
    largeImageURL: String,
    imageWidth: Int,
    imageHeight: Int,
    imageSize: Int,
    views: Int,
    downloads: Int,
    collections: Int,
    likes: Int,
    comments: Int,
    userID: Int,
    user: String,
    userImageURL: String,
    userURL: String,
    noAiTraining: Bool,
    isAiGenerated: Bool,
    isGRated: Bool,
    isLowQuality: Bool
  ) {
    self.id = id
    self.pageURL = pageURL
    self.type = type
    self.tags = tags
    
    self.previewURL = previewURL
    self.previewWidth = previewWidth
    self.previewHeight = previewHeight
    
    self.webformatURL = webformatURL
    self.webformatWidth = webformatWidth
    self.webformatHeight = webformatHeight
    
    self.largeImageURL = largeImageURL
    
    self.imageWidth = imageWidth
    self.imageHeight = imageHeight
    self.imageSize = imageSize
    
    self.views = views
    self.downloads = downloads
    self.collections = collections
    self.likes = likes
    self.comments = comments
    
    self.userID = userID
    self.user = user
    self.userImageURL = userImageURL
    self.userURL = userURL
    
    self.noAiTraining = noAiTraining
    self.isAiGenerated = isAiGenerated
    self.isGRated = isGRated
    self.isLowQuality = isLowQuality
  }
}
