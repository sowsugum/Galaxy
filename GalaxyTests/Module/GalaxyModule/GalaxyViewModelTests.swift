//
//  GalaxyViewModelTest.swift
//  GalaxyTests
//
//  Created by Sowrirajan Sugumaran on 24/01/25.
//

import Foundation
@testable import Galaxy
import XCTest

final class GalaxyViewModelTests: XCTestCase {
    
    var viewModel: GalaxyViewModel!
    var mockGalaxyUsecase: MockGalaxyUsecase!
    
    override func setUp() {
        super.setUp()
        mockGalaxyUsecase = MockGalaxyUsecase()
        viewModel = GalaxyViewModel(useCaseProtocol: mockGalaxyUsecase)
    }
    
    override func tearDown() {
        mockGalaxyUsecase = nil
        viewModel = nil
    }
    
    func testFetchGalaxySuccess() async {
        let expectation = XCTestExpectation(description: "Fetch galaxy successfully")
        
        do {
            let _ = try await mockGalaxyUsecase.execute()
            XCTAssertNotNil(self.viewModel.galaxyList)
            expectation.fulfill()
        } catch {
            XCTFail("Error should not occur: \(error)")
        }
        await fulfillment(of: [expectation], timeout: 1.0)
    }
    
    func testFetchGalaxyError() async {
        let expectation = XCTestExpectation(description: "Fetch galaxy with Error")

        mockGalaxyUsecase.error = .invalidResponse
        do {
            let _ = try await mockGalaxyUsecase.execute()
            XCTFail("Error should not occur")
        } catch {
            XCTAssertEqual(error as! APIError, .invalidResponse)
            expectation.fulfill()
        }
        await fulfillment(of: [expectation], timeout: 1.0)
    }
}
