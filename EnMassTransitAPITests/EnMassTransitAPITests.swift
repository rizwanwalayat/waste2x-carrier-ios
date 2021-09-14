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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSignupSendCodeAPI() throws {
        let phone:String = "+17743777019"
        let promise = expectation(description: "Status Code: 200")
       
        //        forgotPasswordVM.sendSignupOTPCode(phoneNumber: phone)
        APIClient.shared.SendSignupCodeApi(phone: phone) { data, error, status, message in
            XCTAssert(status ==  true && error == nil, "Data Returned with No Error")
                promise.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            if let _ = error {
                XCTAssert(false, "Timeout")
            }
        }    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
