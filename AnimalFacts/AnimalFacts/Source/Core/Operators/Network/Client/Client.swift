//
//  Client.swift
//  AnimalFacts
//
//  Created by Dmitry Polurezov on 22.09.2022.
//

import Foundation

struct Client {
  let baseURL: URL

  func defaultHandler<Result: Decodable>(
    data: Data?,
    response: URLResponse?,
    error: Error?
  ) -> Response<Result> {
    if let error = error as NSError? {
      switch (error.domain, error.code) {
      case (NSURLErrorDomain, NSURLErrorCancelled): return .cancelled
      default: return .failed
      }
    }

    guard let response = response as? HTTPURLResponse else {
      preconditionFailure("Response must be here if error is nil")
    }

    if response.statusCode == 401 { return .unauthorized }
    if response.statusCode != 200 { return .failed }

    guard let data = data else { preconditionFailure("Data need to be here") }
    if let result = data as? Result { return .success(result) }

    do {
      let result = try JSONDecoder().decode(Result.self, from: data)
      return .success(result)
    } catch {
      return .failed
    }
  }

  private func urlRequest(
    for path: PathType,
    with parameters: [URLQueryItem] = [],
    headers: [String: String]? = nil
  ) -> URLRequest {
    let url: URL = {
      switch path {
      case .base:
        return baseURL
      case let .baseAppending(path):
        return baseURL.appendingPathComponent(path)
      case let .custom(path):
        guard let url = URL(string: path) else {
          preconditionFailure("Failed to create URL from path \(path)!")
        }

        return url
      }
    }()

    guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
      fatalError("Couldn't create URLComponents from \(url)!")
    }

    let percentEncodedQuery = (urlComponents.percentEncodedQuery.map { $0 + "&" } ?? .empty)
    urlComponents.percentEncodedQuery = percentEncodedQuery
    urlComponents.queryItems = parameters

    guard let urlComponentsURL = urlComponents.url else {
      fatalError("Couldn't get URL from \(urlComponents)!")
    }

    var request = URLRequest(url: urlComponentsURL)

    if let headers = headers {
      headers.forEach { request.addValue($1, forHTTPHeaderField: $0) }
    }

    return request
  }

  func get(from path: PathType, with params: [URLQueryItem] = [], headers: [String: String]? = nil) -> URLRequest {
    urlRequest(for: path, with: params, headers: headers)
  }

  func request<Result: Decodable>(urlRequest: URLRequest) -> Request<Result> {
    Request(urlRequest: urlRequest, handler: defaultHandler)
  }
}

struct DataResult<Result: Decodable>: Decodable {
  let data: Result
}

extension Client {
  struct Request<Result: Decodable> {
    init(
      urlRequest: URLRequest,
      handler: @escaping (Data?, URLResponse?, Error?) -> Client.Response<Result>
    ) {
      self.urlRequest = urlRequest
      self.handler = handler
    }

    let urlRequest: URLRequest
    let handler: (Data?, URLResponse?, Error?) -> Response<Result>
  }

  enum Response<Result: Decodable> {
    case success(Result)
    case cancelled
    case unauthorized
    case failed
  }
}

extension Client {
  enum PathType {
    case base
    case baseAppending(String)
    case custom(String)
  }
}
