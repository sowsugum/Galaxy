//
//  GalaxyResponseModel.swift
//  Galaxy
//
//  Created by Sowrirajan Sugumaran on 17/01/25.
//

import Foundation

struct GalaxyResponseModel: Codable, Identifiable, Equatable {
    var id: Int?
    let copyright: String?
    let date, explanation: String
    let hdurl: String
    let mediaType: MediaType
    let serviceVersion: ServiceVersion
    let title: String
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case copyright, date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
}

enum MediaType: String, Codable {
    case image = "image"
}

enum ServiceVersion: String, Codable {
    case v1 = "v1"
}

// Converting GalaxyResponseModel to GalaxyDomainData
extension GalaxyResponseModel {
    func toDomain() -> GalaxyDomainData {
        return .init(imageUrl: url,
                     hdImageUrl: hdurl,
                     name: title,
                     description: explanation,
                     copyright: copyright)
    }
}
