//
//  MockGalexyUsecaseProtocol.swift
//  GalaxyTests
//
//  Created by Sowrirajan Sugumaran on 23/01/25.
//

import Testing
@testable import Galaxy

final class MockGalaxyUsecase: GalaxyUseCaseProtocol {
    var galaxy: [GalaxyPresentationData]?
    var error: APIError?
    
    func execute() async throws -> [Galaxy.GalaxyPresentationData] {
        if let _ = error {
            throw APIError.invalidResponse
        }
        let galaxy = galaxy ?? []
        return galaxy
    }
}
