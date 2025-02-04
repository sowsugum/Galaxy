//
//  MockUrlSession.swift
//  GalaxyTests
//
//  Created by Sowrirajan Sugumaran on 23/01/25.
//

import Foundation
import Combine
@testable import Galaxy

final class MockURLSession: URLSessionProtocol {
    var data: Data?
    var error: Error?
    
    func dataTaskPublisher(_ url: URL) -> AnyPublisher<(Data, URLResponse), URLError> {
        if let error = error {
            return Fail(error: error as! URLError).eraseToAnyPublisher()
        }
        guard let data = data else {
            return Fail(error: URLError(.badServerResponse)).eraseToAnyPublisher()
        }
        return Just((data, URLResponse()))
            .setFailureType(to: URLError.self)
            .eraseToAnyPublisher()
    }
}
