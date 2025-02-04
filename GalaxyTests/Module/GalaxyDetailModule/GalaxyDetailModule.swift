//
//  GalaxyDetailModule.swift
//  GalaxyTests
//
//  Created by Sowrirajan Sugumaran on 24/01/25.
//

import XCTest
import SwiftUI
import ViewInspector
@testable import Galaxy

final class GalaxyDetailViewTests: XCTestCase {

    func testGalaxyDetailViewWithValidData() throws {
        let galaxyData = GalaxyPresentationData(
            imageUrl: "placeholderImage",
            hdImageUrl: "placeholderImage",
            name: "M33: The Triangulum Galaxy",
            description: "The small, northern constellation Triangulum harbors this magnificent face-on spiral galaxy, M33. Its popular names include the Pinwheel Galaxy or just the Triangulum Galaxy.",
            copyright: "Rui Liao"
        )
        let detailView = Galaxy.GalaxyDetailView(galaxy: galaxyData)
        let inspectedView = try detailView.inspect()
        let textView = inspectedView.findAll(ViewType.Text.self)

        XCTAssertEqual(try textView[0].string(), "M33: The Triangulum Galaxy")
        XCTAssertEqual(try textView[1].string(), "The small, northern constellation Triangulum harbors this magnificent face-on spiral galaxy, M33. Its popular names include the Pinwheel Galaxy or just the Triangulum Galaxy.")
        XCTAssertEqual(try textView[2].string(), Constants.GalaxyDetail.copyright + "Rui Liao")
    }
    
    func testGalaxyDetailViewWithInvalidData() throws {
        let galaxyData = GalaxyPresentationData(
            imageUrl: "placeholderImage",
            hdImageUrl: "placeholderImage",
            name: nil,
            description: nil,
            copyright: nil
        )
        let detailView = Galaxy.GalaxyDetailView(galaxy: galaxyData)
        let inspectedView = try detailView.inspect()
        let textView = inspectedView.findAll(ViewType.Text.self)

        XCTAssertEqual(try textView[0].string(), "")
        XCTAssertEqual(try textView[1].string(), "")
    }
}
