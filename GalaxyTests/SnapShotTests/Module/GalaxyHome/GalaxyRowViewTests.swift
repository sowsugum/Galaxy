//
//  GalaxyRowViewTests.swift
//  GalaxyTests
//
//  Created by Sowrirajan Sugumaran on 24/01/25.
//

import Foundation
import XCTest
import SwiftUI
@testable import Galaxy

final class GalaxyRowViewTest: XCTestCase {
    func testGalaxyRowDetailView() {
        let galaxyRowView: GalaxyRowView = GalaxyRowView(galaxy: MockTestData.mockGalaxy)
        let viewController = galaxyRowView.toViewController()
        viewController.performSnapshotTests(named: "galaxyRowView")
    }
}
