//
//  NetworkSessionProtocol.swift
//  Galaxy
//
//  Created by Sowrirajan Sugumaran on 22/01/25.
//

import Foundation
import Combine

protocol URLSessionDataTaskProtocol {
    func resume()
}
extension URLSessionDataTask: URLSessionDataTaskProtocol { }

typealias DataCompletionHandler = (Data?, URLResponse?, Error?) -> Void

protocol URLSessionProtocol {
    func dataTaskPublisher(_ url: URL) -> AnyPublisher<(Data, URLResponse), URLError>
}

extension URLSession: URLSessionProtocol {
    func dataTaskPublisher(_ url: URL) -> AnyPublisher<(Data, URLResponse), URLError> {
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { ($0.data, $0.response) }
            .eraseToAnyPublisher()
    }
}
