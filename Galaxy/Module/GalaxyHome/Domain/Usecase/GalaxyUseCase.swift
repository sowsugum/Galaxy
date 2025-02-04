//
//  GalaxyUseCaseImpl.swift
//  Galaxy
//
//  Created by Sowrirajan Sugumaran on 17/01/25.
//

import Foundation

protocol GalaxyUseCaseProtocol {
    func execute() async throws -> [GalaxyPresentationData]
}

struct GalaxyUseCase: GalaxyUseCaseProtocol {
    private let repository: GalaxyRepositoryProtocol
    init(repository: GalaxyRepositoryProtocol) {
        self.repository = repository
    }
    /// To fetch the galaxy list from repository
    ///
    /// - Parameters:
    ///   - returning response in `Result<[GalaxyEntryModel]`.
    ///
    func execute() async throws -> [GalaxyPresentationData] {
        return try await repository.getGalaxy().map { $0.toPresentation() }
    }
}
