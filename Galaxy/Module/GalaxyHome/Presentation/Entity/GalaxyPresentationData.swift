//
//  GalaxyPresentationData.swift
//  Galaxy
//
//  Created by Sowrirajan Sugumaran on 23/01/25.
//

import Foundation

struct GalaxyPresentationData: Hashable, Sendable {
    var id: UUID = UUID()
    var imageUrl: String
    var hdImageUrl: String
    var name: String?
    var description: String?
    var copyright: String?
}
