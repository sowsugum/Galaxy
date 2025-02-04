//
//  MockNetworkManager.swift
//  GalaxyTests
//
//  Created by Sowrirajan Sugumaran on 23/01/25.
//

import Foundation
@testable import Galaxy

struct MockRequest: RequestBuilder {
    var baseURL: Galaxy.BaseURLType = .baseApi
    
    var path: String? = "nasa-pictures.json"
    
    var methodType: Galaxy.HTTPMethod = .get
    
    var pathAppendedURL: URL? {
        var url = baseURL.desc
        if let path = path {
            url?.appendPathComponent(path)
        }
        return url
    }
    
    func buildURLRequest() -> URLRequest? {
        guard let pathAppendedURL = pathAppendedURL else { return nil }
        var urlRequest = URLRequest(url: pathAppendedURL)
        urlRequest.httpMethod = methodType.name
        return urlRequest
    }
}
