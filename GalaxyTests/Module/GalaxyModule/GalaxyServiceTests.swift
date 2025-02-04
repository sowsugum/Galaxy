//
//  GalaxyServiceTest.swift
//  GalaxyTests
//
//  Created by Sowrirajan Sugumaran on 24/01/25.
//

import Foundation
import Combine
@testable import Galaxy
import XCTest

final class GalaxyServiceTests: XCTestCase {
    
    var service: GalaxyServiceProtocol!
    var mockService: MockNetworkManager!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockService = MockNetworkManager()
        service = GalaxyService(service: mockService)
        cancellables = []
    }
    
    override func tearDown() {
        cancellables = []
        super.tearDown()
    }
    
    func testFetchGalaxyList_Success() {

        let expectedGalaxies = MockTestData.galaxy
        mockService.result = .success(expectedGalaxies)
        let expectation = XCTestExpectation(description: "Fetch Galaxy List Success")
        
        service.fetchGalaxyList()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure:
                    XCTFail("Expected successful response")
                case .finished:
                    break
                }
            }, receiveValue: { galaxies in
                XCTAssertEqual(galaxies.count, expectedGalaxies.count)
                XCTAssertEqual(galaxies.first?.title, "Starburst Galaxy M94 from Hubble")
                expectation.fulfill()
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchGalaxyList_Failure() {
        let expectedError = APIError.noData
        mockService.result = .failure(expectedError)
        let expectation = XCTestExpectation(description: "Fetch Galaxy List Failure")
        
        service.fetchGalaxyList()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    XCTAssertEqual(error, expectedError)
                    expectation.fulfill()
                case .finished:
                    XCTFail("Expected failure response")
                }
            }, receiveValue: { galaxies in
                XCTFail("Expected failure, but got galaxies: \(galaxies)")
            })
            .store(in: &cancellables)
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchGalaxyList_MakesCorrectAPIRequest() {
        let expectedRequest = HttpRequest()
        expectedRequest.baseURL = .staging
        expectedRequest.path = EndPoints.Galaxy.list.path
        let expectedGalaxies = MockTestData.galaxy
        mockService.result = .success(expectedGalaxies)

        let _ = service.fetchGalaxyList()
            .sink(receiveCompletion: { _ in }, receiveValue: { _ in })
            .store(in: &cancellables)
        
        XCTAssertEqual(expectedRequest.baseURL.desc?.absoluteString, "https://raw.githubusercontent.com/obvious/take-home-exercise-data/trunk")
        XCTAssertEqual(expectedRequest.path, EndPoints.Galaxy.list.path)
    }
}
