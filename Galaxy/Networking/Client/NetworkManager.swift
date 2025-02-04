//
//  ClientManager.swift
//  Galaxy
//
//  Created by Sowrirajan Sugumaran on 21/01/25.
//

import Foundation
import Combine

protocol NetworkProtocol {
    func perform<T: Decodable>(with request:
                               RequestBuilder?, responseObject type: T.Type) -> AnyPublisher<T, APIError>
}

final class NetworkClientManager: NetworkProtocol {
    typealias AnyPublisherResult<M> = AnyPublisher<M, APIError>
    
    private let session: URLSessionProtocol
    
    public init(session: URLSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func perform<T: Decodable>(with request: RequestBuilder?, responseObject type: T.Type) -> AnyPublisher<T, APIError> {
        
        APIDebugger().logRequest(request: request?.buildURLRequest())
        
        guard let url = request?.buildURLRequest()?.url else {
            return Fail(error: APIError.urlError)
                .eraseToAnyPublisher()
        }
        
        return session.dataTaskPublisher(url)
            .tryMap { data, response in
                APIDebugger().logResponse(response: response, data: data)

                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    return decodedData
                } catch {
                    throw APIError.invalidResponse
                }
            }
            .mapError { error in
                if let apiError = error as? APIError {
                    return apiError
                }
                return APIError.serverError(error: error.localizedDescription)
            }
            .eraseToAnyPublisher()
    }
}
