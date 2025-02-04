//
//  HttpTests.swift
//  GalaxyTests
//
//  Created by Sowrirajan Sugumaran on 24/01/25.
//

import Foundation
import XCTest
@testable import Galaxy

final class HTTPMethodTests: XCTestCase {

    func testGetMethodName() {
        let method: HTTPMethod = .get
        let methodName = method.name
        
        XCTAssertEqual(methodName, "GET")
    }

    func testPostMethodName() {
        let method: HTTPMethod = .post
        let methodName = method.name

        XCTAssertEqual(methodName, "POST")
    }

    func testPutMethodName() {
        let method: HTTPMethod = .put
        let methodName = method.name
        
        XCTAssertEqual(methodName, "PUT")
    }

    func testDeleteMethodName() {
        let method: HTTPMethod = .delete
        let methodName = method.name
        
        XCTAssertEqual(methodName, "DELETE")
    }
}
