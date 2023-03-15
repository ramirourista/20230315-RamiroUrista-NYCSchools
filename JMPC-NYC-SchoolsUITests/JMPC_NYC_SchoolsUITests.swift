//
//  JMPC_NYC_SchoolsUITests.swift
//  JMPC-NYC-SchoolsUITests
//
//  Created by Ramiro on 3/14/23.
//

import XCTest
import RxSwift

@testable import JMPC_NYC_Schools

class JMPC_NYC_SchoolsUITests: XCTestCase {

    private var mockRequestsManager: MockRequestsManager!
    private var viewModel: MainFeedViewModel!
    
    override func setUp() {
        super.setUp()
        mockRequestsManager = MockRequestsManager()
        viewModel = MainFeedViewModel(requestsManager: mockRequestsManager)
    }

    override func tearDown() {
        //sut = nil
        mockRequestsManager = nil
        super.tearDown()
    }
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

class MockRequestsManager: RequestsManagerProtocol {
    func fetchHighSchoolDetailRecords(with url: URL) -> Single<[HighSchoolDetailRecord]> {
        .just([HighSchoolDetailRecord()])
    }
    
    func fetchHighSchoolRecords(with url: URL) -> Single<[HighSchoolRecord]> {
        let highSchoolRecord = [HighSchoolRecord(dbn: "ABC", city: "Manhatan"),
                                HighSchoolRecord(dbn: "CDE", city: "Chicago")]
        
        return .just(highSchoolRecord)
    }
    
    
}

