//
//  APIError.swift
//  PhotoGallery
//
//  Created by Varun Mehta on 26/4/22.
//

import SwiftUI

enum APIError: Error, Equatable {
    case request(message: String)
    case network(message: String)
    case status(message: String, code: Int)
    case parsing(message: String)
    case other(message: String)
    
    static func map(_ error: Error) -> APIError {
        return (error as? APIError) ?? .other(message: error.localizedDescription)
    }
    
    static func == (lhs: APIError, rhs: APIError) -> Bool {
                switch (lhs, rhs) {
                case (let .request(lhsMessage), let .request(rhsMessage)):
                      return (lhsMessage) == (rhsMessage)
                default: return false
                }
            }

}
