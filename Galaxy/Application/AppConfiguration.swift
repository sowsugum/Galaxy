//
//  AppConfiguration.swift
//  Galaxy
//
//  Created by Sowrirajan Sugumaran on 23/01/25.
//

import Foundation

enum BaseURLType {
    case baseApi
    case staging

    var desc: URL? {
        switch self {
        case .baseApi:
            return URL(string: BASEURL.dev)
        case .staging:
            return URL(string: BASEURL.staging)
        }
    }
}

enum BASEURL {
    //MARK: - DEVELOPMENT SERVER
    static let dev = "https://raw.githubusercontent.com/obvious/take-home-exercise-data/trunk"

    //MARK: - STAGING SERVER
    static let staging = "https://raw.githubusercontent.com/obvious/take-home-exercise-data/trunk"
    
    //MARK: - PRODUCTION SERVER
    static let production = "https://raw.githubusercontent.com/obvious/take-home-exercise-data/trunk"
}

enum EndPoints {
    // MARK: - Galaxy Module
    enum Galaxy {
        case list
        
        var path: String {
            switch self {
            case .list:
                "/nasa-pictures.json"
            }
        }
    }
}
