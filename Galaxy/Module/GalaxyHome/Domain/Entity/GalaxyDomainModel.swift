//
//  GalaxyEntryModel.swift
//  Galaxy
//
//  Created by Sowrirajan Sugumaran on 17/01/25.
//

import Foundation

struct GalaxyDomainData: Hashable, Sendable {
    var id: UUID = UUID()
    var imageUrl: String
    var hdImageUrl: String
    var name: String?
    var description: String?
    var copyright: String?
}
// Converting GalaxyDomainData to GalaxyPresentationData
extension GalaxyDomainData {
    func toPresentation() -> GalaxyPresentationData {
        .init(imageUrl: imageUrl,
              hdImageUrl: hdImageUrl,
              name: name,
              description: description,
              copyright: copyright)
    }
}
