//
//  MockGalaxyRepository.swift
//  GalaxyTests
//
//  Created by Sowrirajan Sugumaran on 23/01/25.
//

import Foundation
@testable import Galaxy

final class MockGalaxyRepository: GalaxyRepositoryProtocol {
    
    var galaxy: [GalaxyDomainData]?
    var error: APIError?
    
    func getGalaxy() async throws -> [Galaxy.GalaxyDomainData] {
        if let error = error {
            throw APIError.serverError(error: error.desc)
        }
        let galaxy = galaxy ?? []
        return galaxy
    }
}
