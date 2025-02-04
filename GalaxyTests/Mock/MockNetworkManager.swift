//
//  MockNetworkManager.swift
//  GalaxyTests
//
//  Created by Sowrirajan Sugumaran on 24/01/25.
//

import Foundation
import Combine
@testable import Galaxy
import XCTest

final class MockNetworkManager: NetworkProtocol {
    var result: Result<Any, APIError>?
    
    func perform<T>(with request: (any Galaxy.RequestBuilder)?, responseObject type: T.Type) -> AnyPublisher<T, Galaxy.APIError> where T : Decodable {
        guard let result = self.result else {
            fatalError("MockNetworkService result not set")
        }
        
        switch result {
        case .success(let response):
            if let response = response as? T {
                return Just(response).setFailureType(to: APIError.self).eraseToAnyPublisher()
            }
        case .failure(let error):
            return Fail(error: error).eraseToAnyPublisher()
        }
        return Empty().eraseToAnyPublisher() // Default fallback
    }
}
