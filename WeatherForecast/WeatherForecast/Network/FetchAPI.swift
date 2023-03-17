//
//  FetchAPI.swift
//  PhotoGallery
//
//  Created by Varun Mehta on 27/4/22.
//

import Foundation
import Combine

/// The request method you like to use
enum HttpMethod: String {
    case get
    case post
    case put
    case delete

    var method: String { rawValue.uppercased() }
}

protocol Fetchable {
    func fetch<T>(with request: URLRequest, session: URLSession) -> AnyPublisher<T,APIError> where T: Codable
}

extension Fetchable {
    func fetch<T>(with request: URLRequest, session: URLSession) -> AnyPublisher<T,APIError> where T: Codable {
        return session.dataTaskPublisher(for: request)
          .mapError { error in
             APIError.network(message: error.localizedDescription)
          }
        
          .flatMap { data, response -> AnyPublisher<T, APIError> in
                   
                   guard let response = response as? HTTPURLResponse else {
                       return Fail(error: APIError.request(message: "Invalid URL")).eraseToAnyPublisher()
                   }
                   
                   print(response.statusCode)
                   let jsonDecoder = JSONDecoder()
                   
              if !(200..<300).contains(response.statusCode) {
                  return Fail(error: APIError.status(message: "\(response.description)", code: response.statusCode)).eraseToAnyPublisher()
              }

                       return Just(data)
                           .decode(type: T.self, decoder: jsonDecoder)
                           .mapError {
                               error in APIError.parsing(message: error.localizedDescription)
                               
                           }
                           .eraseToAnyPublisher()
               }
          .eraseToAnyPublisher()
    }
}
