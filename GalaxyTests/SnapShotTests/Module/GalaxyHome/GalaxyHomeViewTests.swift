//
//  GalaxyHomeViewTests.swift
//  Galaxy
//
//  Created by Sowrirajan Sugumaran on 24/01/25.
//

import XCTest
import SwiftUI
@testable import Galaxy

final class GalaxyHomeViewTests: XCTestCase {
    func testGalaxyListView() {
        let galaxyList: GalaxyListView = GalaxyListView(galaxyList: [MockTestData.mockGalaxy])
        let viewController = galaxyList.toViewController()
        viewController.performSnapshotTests(named: "galaxyList")
    }
}
