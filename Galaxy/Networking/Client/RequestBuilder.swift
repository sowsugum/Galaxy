//
//  RequestBuilder.swift
//  Galaxy
//
//  Created by Sowrirajan Sugumaran on 21/01/25.
//

import Foundation

protocol RequestBuilder {
    var baseURL: BaseURLType { get }
    var path: String? { get }
    var methodType: HTTPMethod { get }
    var pathAppendedURL: URL? { get }
    func buildURLRequest() -> URLRequest?
}


final class HttpRequest: RequestBuilder {
    var baseURL: BaseURLType = .baseApi
    var path: String? = ""
    var methodType: HTTPMethod = .get

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
