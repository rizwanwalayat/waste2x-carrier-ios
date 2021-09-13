//
//  EnMassTransitUITests.swift
//  EnMassTransitUITests
//
//  Created by Phaedra Solutions  on 13/09/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import XCTest

class EnMassTransitUITests: XCTestCase {

    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
   
    func testLogin(){
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.textFields["loginPhoneNoTextField"].tap()
        
        let key0 = app.keyboards.keys["0"]

        let key1 = app/*@START_MENU_TOKEN@*/.keyboards.keys["1"]/*[[".keyboards.keys[\"1\"]",".keys[\"1\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        let key2 = app/*@START_MENU_TOKEN@*/.keyboards.keys["2"]/*[[".keyboards.keys[\"2\"]",".keys[\"2\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        let key3 = app/*@START_MENU_TOKEN@*/.keyboards.keys["3"]/*[[".keyboards.keys[\"3\"]",".keys[\"3\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        let key4 = app.keyboards.keys["4"]

        let key5 = app/*@START_MENU_TOKEN@*/.keyboards.keys["5"]/*[[".keyboards.keys[\"5\"]",".keys[\"5\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        let key6 = app.keyboards.keys["6"]
        let key7 = app/*@START_MENU_TOKEN@*/.keyboards.keys["7"]/*[[".keyboards.keys[\"7\"]",".keys[\"7\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        let key9 = app/*@START_MENU_TOKEN@*/.keyboards.keys["9"]/*[[".keyboards.keys[\"9\"]",".keys[\"9\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/

        key7.tap()
        key7.tap()
        key3.tap()
        key4.tap()
        key7.tap()
        key7.tap()
        key7.tap()
        key0.tap()
        key1.tap()
        key9.tap()

        elementsQuery/*@START_MENU_TOKEN@*/.secureTextFields["loginPasswordTextField"]/*[[".secureTextFields[\"Password\"]",".secureTextFields[\"loginPasswordTextField\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

        let moreKey = app/*@START_MENU_TOKEN@*/.keys["more"]/*[[".keyboards",".keys[\"numbers\"]",".keys[\"more\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        moreKey.tap()
        
        key1.tap()
        key2.tap()
        key3.tap()
        key4.tap()
        key5.tap()
        key6.tap()
      
        app.toolbars["Toolbar"].buttons["Done"].tap()
        elementsQuery/*@START_MENU_TOKEN@*/.staticTexts["Login"]/*[[".buttons[\"Login\"].staticTexts[\"Login\"]",".buttons[\"loginBtn\"].staticTexts[\"Login\"]",".staticTexts[\"Login\"]"],[[[-1,2],[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    
    }
    
    func signupUser() throws {
        
    }

}
