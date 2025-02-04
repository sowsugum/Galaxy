//
//  GalaxyDetailViewTests.swift
//  GalaxyTests
//
//  Created by Sowrirajan Sugumaran on 24/01/25.
//

import Foundation
import XCTest
import SwiftUI
@testable import Galaxy


final class GalaxyDetailViewSnapshotTests: XCTestCase {
    func testGalaxyDetailView() {
        let galaxyDetailView: GalaxyDetailView = GalaxyDetailView(galaxy: MockTestData.mockGalaxy)
        let viewController = galaxyDetailView.toViewController()
        viewController.performSnapshotTests(named: "GalaxyDetailView")
    }
}
