//
//  NetworkManager.swift
//  pixabay
//
//  Created by SID on 23/12/2025.
//


import Foundation

let APIKEY = "53853928-5326c1b98a4c55a1621116eac"
let baseURL = "https://pixabay.com/api"

enum RequestMethod: String {
  case get = "GET"
  case post = "POST"
  case put = "PUT"
  case patch = "PATCH"
  case delete = "DELETE"
}
enum RequestError: Error {
  case decode
  case invalidURL
  case noResponse
  case JSONSerialization
  case unAuthorized(reason: String?)
  case serverError(reason: String)
  case sessionExpired
  case unexpectedStatusCode
  case unknown
  
  var customMessage: String {
    switch self {
    case .decode:
      "Decode error"
    case .JSONSerialization:
      "Failed Serialisation the body"
    case .unAuthorized(let reason):
      reason ?? "Session expired"
    default:
      "Unknown error"
    }
  }
}
protocol Endpoint {
    var path: String? { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: Any?]? { get }
    var queryItems: [URLQueryItem]? { get }
}

protocol NetworkManagerService {
  func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError>
}


extension Endpoint {
  var body: [String: Any?]? { nil }
  var header: [String: String]? {
    return ["Content-Type": "application/json"]
  }
  var queryItems: [URLQueryItem]? { nil }
}


extension NetworkManagerService {
  
  func sendRequest<T: Decodable>(endpoint: Endpoint, responseModel: T.Type) async -> Result<T, RequestError> {
    
    let baseURLString = baseURL
    guard !baseURLString.isEmpty,
          var urlComponents = URLComponents(string: baseURLString) else {
      return .failure(.invalidURL)
    }
    
    urlComponents.path += endpoint.path ?? ""
    urlComponents.queryItems = endpoint.queryItems
    
    guard let url = urlComponents.url else {
      return .failure(.invalidURL)
    }
    var request = URLRequest(url: url)
    request.httpMethod = endpoint.method.rawValue
    request.allHTTPHeaderFields = endpoint.header
    //    request.timeoutInterval = 20
    
#if DEBUG
    debugPrint("🔗 URL \(request)")
    debugPrint("🔄 timeoutInterval \(request.timeoutInterval)")
    debugPrint("📤 Request Headers: \(request.allHTTPHeaderFields ?? [:])")
#endif
    if let body = endpoint.body {
      do {
        let jsonData = try JSONSerialization.data(withJSONObject: body, options: [])
        request.httpBody = jsonData
#if DEBUG
        debugPrint("📝 Request Body: \(String(decoding: jsonData, as: UTF8.self))")
#endif
      } catch {
        return .failure(.JSONSerialization)
      }
    }
    
    do {
      let (data, response) = try await URLSession.shared.data(for: request)
      guard let httpResponse = response as? HTTPURLResponse else {
        return .failure(.noResponse)
      }
#if DEBUG
      debugPrint("📥 Response: \(String(data: data, encoding: .utf8) ?? "")")
#endif
      switch httpResponse.statusCode {
      case 200...299:
        do {
          let decoded = try JSONDecoder().decode(responseModel, from: data)
          return .success(decoded)
        } catch {
#if DEBUG
          debugPrint("❌ Decode error: \(error)")
#endif
          return .failure(.decode)
        }
        
      case 400...499:
        printPrettyJSON(data)
        return .failure(.unAuthorized(reason: "Client error"))
      default:
        printPrettyJSON(data)
            return .failure(.serverError(reason: "Server error"))

      }
    } catch {
      return .failure(.unAuthorized(reason: error.localizedDescription))
    }
  }
  
  private func printPrettyJSON(_ data: Data) {
      do {
          let jsonObject = try JSONSerialization.jsonObject(with: data, options: [])
          let prettyData = try JSONSerialization.data(
              withJSONObject: jsonObject,
              options: [.prettyPrinted, .sortedKeys]
          )

          if let prettyString = String(data: prettyData, encoding: .utf8) {
              print("🔴 API Error Response:\n\(prettyString)")
          }
      } catch {
          // Fallback if response is not valid JSON
          if let rawString = String(data: data, encoding: .utf8) {
              print("🔴 API Error (Raw):\n\(rawString)")
          } else {
              print("🔴 API Error: Unable to decode response data")
          }
      }
  }

}
