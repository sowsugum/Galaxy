//
//  NetworkClientProtocol.swift
//  Galaxy
//
//  Created by Sowrirajan Sugumaran on 21/01/25.
//

import Foundation
import Combine

enum APIError: Error, Equatable {
    case general
    case pageNotFound
    case noData
    case noNetwork
    case serverError(error: String)
    case invalidResponse
    case urlError
}

extension APIError {
    /// Description of error
    var desc: String {
        switch self {
        case .general:                    return Constants.ServerError.general
        case .pageNotFound:               return Constants.ServerError.notFound
        case .noData:                     return Constants.ServerError.notFound
        case .noNetwork:                  return Constants.ServerError.noInternet
        case .serverError(let error):     return error
        case .invalidResponse:            return Constants.ServerError.invalidResponse
        case .urlError:                   return Constants.ServerError.urlError
        }
    }
}
