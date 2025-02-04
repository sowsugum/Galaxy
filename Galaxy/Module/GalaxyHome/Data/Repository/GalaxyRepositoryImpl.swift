//
//  GalaxyRepositoryImpl.swift
//  Galaxy
//
//  Created by Sowrirajan Sugumaran on 17/01/25.
//

import Foundation
import Combine

final class GalaxyRepository: ParentRepository, GalaxyRepositoryProtocol {
    private let service: GalaxyServiceProtocol
    
    init(service: GalaxyServiceProtocol) {
        self.service = service
    }
    /// To fetch galaxy list as an async result
    ///
    /// - Parameters:
    ///   - returning converting into [GalaxyDomainData].
    ///
    func getGalaxy() async throws -> [GalaxyDomainData] {
        let galaxyResponse = try await self.handleModel(service.fetchGalaxyList())
        return galaxyResponse.map { $0.toDomain() }
    }
}
