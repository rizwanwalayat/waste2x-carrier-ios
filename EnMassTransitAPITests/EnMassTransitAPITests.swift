//
//  EnMassTransitAPITests.swift
//  EnMassTransitAPITests
//
//  Created by Phaedra Solutions  on 14/09/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import XCTest
@testable import EnMass_Transit

class EnMassTransitAPITests: XCTestCase {
    
    override func setUpWithError() throws {
        DataManager.shared.saveAuthToken("a96201bf94444ba5ee1757bc66cbb782dd80838a")
        DataManager.shared.saveUsersDetail("{\"phone\":\"+17734777019\",\"email\":\"+17734777019@cache.com\",\"name\":\"Brian Smith\",\"auth_token\":\"a96201bf94444ba5ee1757bc66cbb782dd80838a\",\"id\":265645,\"image\":\"https:\\/\\/storage.googleapis.com\\/staging-cache\\/user-activity\\/phaedra_solution_JPEG_38472504718216_9114838128545487973-2021-10-25-014118.png\"}")
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDispatchesListAPI() throws {
        
        let promise = expectation(description: "Status Code: 200")
        let viewModel = DispatchesListVM()
        
        viewModel.fetchDispatchesData({ result, error, status, message in
            XCTAssert(status == true, "API Response Status False")
            XCTAssertNil(error, "API Response with Error: "+message)
            
            promise.fulfill()
        })
        
        waitForExpectations(timeout: 10) { error in
            if let _ = error {
                XCTFail("Timeout after 10sec")
            }
        }
    }
    
    func testDispatchesDetailAPI() throws {
        
        let promise = expectation(description: "Status Code: 200")
        let viewModel = DispatchesDetailVM()
        viewModel.id = 55 // Setting Dispatch ID in VM to fetch data from API function
        viewModel.FetchDispatchesDetailData({ result, error, status, message in
            XCTAssert(status == true, "API Response Status False")
            XCTAssertNil(error, "API Response with Error: "+message)
            
            promise.fulfill()
        })
        
        waitForExpectations(timeout: 10) { error in
            if let _ = error {
                XCTFail("Timeout after 10sec")
            }
        }
    }
    
    func testQuotationsListAPI() throws {
        
        let promise = expectation(description: "Status Code: 200")
        let viewModel = QuotationViewModel()
        
        viewModel.FetchQuotationData({ result, error, status, message in
            XCTAssert(status == true, "API Response Status False")
            XCTAssertNil(error, "API Response with Error: "+message)
            
            promise.fulfill()
        })
        
        waitForExpectations(timeout: 10) { error in
            if let _ = error {
                XCTFail("Timeout after 10sec")
            }
        }
    }
    
    
    func testQuotationsDetailAPI() throws {
        
        let promise = expectation(description: "Status Code: 200")
        let viewModel = QuotationViewModel()
        let quotationNo = "72" // Sending this Quotation No to Fetch Function
        viewModel.FetchQuotationDetailData(qoute: quotationNo, { result, error, status, message in
            XCTAssert(status == true, "API Response Status False")
            XCTAssertNil(error, "API Response with Error: "+message)
            
            promise.fulfill()
        })
        
        waitForExpectations(timeout: 10) { error in
            if let _ = error {
                XCTFail("Timeout after 10sec")
            }
        }
    }
    
    func testReceivablesListAPI() throws {
        
        let promise = expectation(description: "Status Code: 200")
        let viewModel = ReceiveableViewModel()
        
        viewModel.FetchReceiveableData({ result, error, status, message in
            XCTAssert(status == true, "API Response Status False")
            XCTAssertNil(error, "API Response with Error: "+message)
            
            promise.fulfill()
        })
        
        waitForExpectations(timeout: 10) { error in
            if let _ = error {
                XCTFail("Timeout after 10sec")
            }
        }
    }
    
    func testTwilioFetchToken() throws {
        
        let promise = expectation(description: "Status Code: 200")
        let viewModel = MessagesViewModel()
        viewModel.fetchTwillioAccessToken({ result, error, status, message in
            XCTAssert(status == true, "API Response Status False")
            XCTAssertNil(error, "API Response with Error: "+message)
            
            promise.fulfill()
        })
        
        waitForExpectations(timeout: 10) { error in
            if let _ = error {
                XCTFail("Timeout after 10sec")
            }
        }
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
