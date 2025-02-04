//
//  RemoteDatasource.swift
//  Galaxy
//
//  Created by Sowrirajan Sugumaran on 17/01/25.
//

import Foundation
import Combine

/// GalaxyServiceProtocol.
///
/// - Parameters:
///   - returning: Publisher which receives from server reponse: `AnyPublisher<[GalaxyResponseModel], ServerError>`.
///
protocol GalaxyServiceProtocol {
    func fetchGalaxyList() -> AnyPublisher<[GalaxyResponseModel], APIError>
}

final class GalaxyService: GalaxyServiceProtocol {
    private let service: NetworkProtocol
    
    init(service: NetworkProtocol) {
        self.service = service
    }
    /// fetchGalaxyList.
    ///     Configure http request data and make a connection with server.
    /// - Parameters:
    ///   - returning: Publisher which receives from server reponse: `AnyPublisher<[GalaxyResponseModel], ServerError>`.
    ///
    func fetchGalaxyList() -> AnyPublisher<[GalaxyResponseModel], APIError> {
        self.service.perform(with: getRequest(), responseObject: [GalaxyResponseModel].self)
    }
    /// getRequest.
    ///     Configure http request data
    /// - Parameters:
    ///   - returning: HttpRequest.
    ///
    private func getRequest() -> HttpRequest {
        let galaxyRequest = HttpRequest()
        galaxyRequest.baseURL = .baseApi
        galaxyRequest.path = EndPoints.Galaxy.list.path
        return galaxyRequest
    }
}
