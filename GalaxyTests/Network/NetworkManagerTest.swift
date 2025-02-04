//
//  NetworkManagerTest.swift
//  GalaxyTests
//
//  Created by Sowrirajan Sugumaran on 23/01/25.
//

import Foundation
@testable import Galaxy
import Combine
import XCTest

final class NetworkManagerTest: XCTestCase {
    
    var mockSession: MockURLSession!
    var networkManager: NetworkClientManager!
    var mockRequest: MockRequest!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        mockSession = MockURLSession()
        networkManager = NetworkClientManager(session: mockSession)
        mockRequest = MockRequest()
    }
    
    override func tearDown() {
        mockSession = nil
        networkManager = nil
        mockRequest = nil
        super.tearDown()
    }
    
    func testPerformWithInvalidURL() {
        let _ = [GalaxyResponseModel(copyright: "Rui Liao", date: "2019-12-31", explanation: "The small, northern constellation Triangulum harbors this magnificent face-on spiral galaxy, M33. Its popular names include the Pinwheel Galaxy or just the Triangulum Galaxy.", hdurl: "placeholderImage", mediaType: .image, serviceVersion: .v1, title: "M33: The Triangulum Galaxy", url: "placeholderImage")]
        let expectedError = "The operation couldn’t be completed. (Galaxy.APIError error 0.)"
        
        mockSession.data = nil
        mockSession.error = nil
        mockRequest.path = nil
        let expectation = self.expectation(description: "Expect failure due to invalid URL")
        _ = networkManager.perform(with: mockRequest, responseObject: [GalaxyResponseModel].self)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTAssertEqual(error.localizedDescription, expectedError)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in })
        
        waitForExpectations(timeout: 2, handler: nil)
    }
    
    func testPerformWithValidResponse() {
        let mockResponseData = """
            [
                {
                    "copyright": "ESA/HubbleNASA",
                    "date": "2019-12-01",
                    "explanation": "Why does this galaxy have a ring of bright blue stars?  Beautiful island universe Messier 94 lies a mere 15 million light-years distant in the northern constellation of the Hunting Dogs (Canes Venatici).",
                    "hdurl": "placeholderImage",
                    "media_type": "image",
                    "service_version": "v1",
                    "title": "Starburst Galaxy M94 from Hubble",
                    "url": "placeholderImage"
                }
            ]
            """.data(using: .utf8)!
        
        mockSession.data = mockResponseData
        mockSession.error = nil
        
        let expectation = self.expectation(description: "Expect successful decoding")
        
        _ = networkManager.perform(with: mockRequest, responseObject: [GalaxyResponseModel].self)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    XCTFail("Expected success, got error: \(error)")
                }
            }, receiveValue: { response in
                XCTAssertEqual(response.first?.title, "Starburst Galaxy M94 from Hubble")
                XCTAssertEqual(response.first?.serviceVersion, .v1)
                XCTAssertEqual(response.first?.date, "2019-12-01")
                XCTAssertEqual(response.first?.url, "placeholderImage")
                XCTAssertEqual(response.first?.copyright, "ESA/HubbleNASA")
                XCTAssertEqual(response.first?.hdurl, "placeholderImage")
                XCTAssertEqual(response.first?.mediaType, .image)
                XCTAssertEqual(response.first?.explanation, "Why does this galaxy have a ring of bright blue stars?  Beautiful island universe Messier 94 lies a mere 15 million light-years distant in the northern constellation of the Hunting Dogs (Canes Venatici).")
                expectation.fulfill()
            })
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testPerformWithInvalidResponse() {

        let invalidResponseData = """
           { "invalid": "data" }
           """.data(using: .utf8)!
        let expectedError = "The operation couldn’t be completed. (Galaxy.APIError error 5.)"
        mockSession.data = invalidResponseData
        mockSession.error = nil
        
        let expectation = self.expectation(description: "Expect invalid response error")
        
        _ = networkManager.perform(with: mockRequest, responseObject: [GalaxyResponseModel].self)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    // Assert
                    XCTAssertEqual(error.localizedDescription, expectedError)
                    expectation.fulfill()
                }
            }, receiveValue: { _ in })
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
