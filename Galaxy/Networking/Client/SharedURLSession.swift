//
//  SharedURLSession.swift
//  Galaxy
//
//  Created by Sowrirajan Sugumaran on 23/01/25.
//

import Foundation

final class SharedURLSession {
    static var shared: URLSession = {
        let configuration = URLSessionConfiguration.default
        let delegate = SharedSessionDelegate()
        return URLSession(configuration: configuration, delegate: delegate, delegateQueue: OperationQueue.main)
    }()
}
