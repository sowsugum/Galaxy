//
//  Constants.swift
//  Galaxy
//
//  Created by Sowrirajan Sugumaran on 17/01/25.
//

import Foundation

enum Constants {
    
    enum Home {
        static let title = "Galaxy"
    }
    
    enum GalaxyDetail {
        static let copyright = "© "
    }
    
    enum ServerError {
        static let general: String = "Bad Request"
        static let noInternet: String = "Check the Connection"
        static let notFound: String = "No Result"
        static let serverError: String = "Internal Server Error"
        static let invalidResponse: String = "Invalid Server Response"
        static let urlError: String = "Invalid URL"
    }
}
