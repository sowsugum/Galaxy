//
//  MockGalaxyHomeViewModel.swift
//  GalaxyTests
//
//  Created by Sowrirajan Sugumaran on 24/01/25.
//

import Foundation
@testable import Galaxy

final class MockGalaxyHomeViewModel: GalaxyViewModelProtocol {
    func fetch() async throws {    }
    var galaxyList: [Galaxy.GalaxyPresentationData] = []
}
