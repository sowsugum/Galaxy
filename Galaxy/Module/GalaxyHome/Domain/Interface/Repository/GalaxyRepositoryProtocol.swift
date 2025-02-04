//
//  GalaxyRepositoryProtocol.swift
//  Galaxy
//
//  Created by Sowrirajan Sugumaran on 17/01/25.
//

import Foundation

protocol GalaxyRepositoryProtocol {
    func getGalaxy() async throws -> [GalaxyDomainData]
}
