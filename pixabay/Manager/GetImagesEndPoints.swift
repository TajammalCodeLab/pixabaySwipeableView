//
//  GetImagesEndPoints.swift
//  pixabay
//
//  Created by SID on 23/12/2025.
//


import Foundation

enum GetImagesEndPoints: Endpoint {
  
  case fetchImages(page: String, imageType: String)
  
  var path: String? {
    switch self {
    case .fetchImages:
      return nil
    }
  }
  var method: RequestMethod {
    switch self {
    case .fetchImages:
        .get
    }}
  var queryItems: [URLQueryItem]? {
    switch self {
    case .fetchImages(let page, let imageType):
      [URLQueryItem(name: "key", value: APIKEY),URLQueryItem(name: "q", value: imageType),URLQueryItem(name: "image_type", value: "photo"),
         URLQueryItem(name: "per_page", value: page), URLQueryItem(name: "safesearch", value: "true")]
    }
  }
  
  
}
