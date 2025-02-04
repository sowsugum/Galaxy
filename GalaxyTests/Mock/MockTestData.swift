//
//  MockTestData.swift
//  GalaxyTests
//
//  Created by Sowrirajan Sugumaran on 23/01/25.
//

import Foundation
@testable import Galaxy

final class MockTestData {
   
    static var galaxy: [GalaxyResponseModel] {
        try! JSONDecoder().decode([GalaxyResponseModel].self, from: galaxyData)
    }
    
    static var galaxyDomainData: [GalaxyDomainData] {
        galaxy.map { $0.toDomain() }
    }
    
    static var galaxyPresentationData: [GalaxyPresentationData] {
        galaxyDomainData.map { $0.toPresentation() }
    }
    
    static var galaxyData: Data {
        loadJsonData("Galaxy")
    }
    
    static func loadJsonData(_ fromFile: String) -> Data {
        let path = Bundle(for: self).path(forResource: fromFile, ofType: "json")
        let jsonString = try! String(contentsOfFile: path!, encoding: .utf8)
        let data = jsonString.data(using: .utf8)!
        return data
    }
    
    static let mockGalaxy = GalaxyPresentationData(
        imageUrl: "placeholderImage",
        hdImageUrl: "placeholderImage",
        name: "M33: The Triangulum Galaxy",
        description: "The small, northern constellation Triangulum harbors this magnificent face-on spiral galaxy, M33. Its popular names include the Pinwheel Galaxy or just the Triangulum Galaxy.",
        copyright: "Rui Liao"
    )
}

