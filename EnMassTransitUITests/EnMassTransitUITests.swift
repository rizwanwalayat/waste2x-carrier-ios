//
//  EnMassTransitUITests.swift
//  EnMassTransitUITests
//
//  Created by Phaedra Solutions  on 13/09/2021.
//  Copyright © 2021 codesrbit. All rights reserved.
//

import XCTest
@testable import EnMass_Transit

class EnMassTransitUITests: XCTestCase {

    var app: XCUIApplication!
    
    var key0: XCUIElement!
    var key1: XCUIElement!
    var key2: XCUIElement!
    var key3: XCUIElement!
    var key4: XCUIElement!
    var key5: XCUIElement!
    var key6: XCUIElement!
    var key7: XCUIElement!
    var key8: XCUIElement!
    var key9: XCUIElement!
    var codeString = ""

    override func setUpWithError() throws {
        
        try super.setUpWithError()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
        key0 = app.keyboards.keys["0"]
        key1 = app/*@START_MENU_TOKEN@*/.keyboards.keys["1"]/*[[".keyboards.keys[\"1\"]",".keys[\"1\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        key2 = app/*@START_MENU_TOKEN@*/.keyboards.keys["2"]/*[[".keyboards.keys[\"2\"]",".keys[\"2\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        key3 = app/*@START_MENU_TOKEN@*/.keyboards.keys["3"]/*[[".keyboards.keys[\"3\"]",".keys[\"3\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        key4 = app.keyboards.keys["4"]
        key5 = app/*@START_MENU_TOKEN@*/.keyboards.keys["5"]/*[[".keyboards.keys[\"5\"]",".keys[\"5\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        key6 = app.keyboards.keys["6"]
        key7 = app/*@START_MENU_TOKEN@*/.keyboards.keys["7"]/*[[".keyboards.keys[\"7\"]",".keys[\"7\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        key8 = app.keyboards.keys["8"]
        key9 = app/*@START_MENU_TOKEN@*/.keyboards.keys["9"]/*[[".keyboards.keys[\"9\"]",".keys[\"9\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
    }
   
    func tap(key: String){
        switch key {
        case "0":
            key0.tap()
        case "1":
            key1.tap()
        case "2":
            key2.tap()
        case "3":
            key3.tap()
        case "4":
            key4.tap()
        case "5":
            key5.tap()
        case "6":
            key6.tap()
        case "7":
            key7.tap()
        case "8":
            key8.tap()
        case "9":
            key9.tap()
        default:
            print("No Key")
        }
    }
    
    func tapCode(code: String){
        
    }
    
    func testLogin(){
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.textFields["loginPhoneNoTextField"].tap()
        
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
    
    func testSignupUser() throws {
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery/*@START_MENU_TOKEN@*/.buttons["SignupBtn"].staticTexts["Sign Up"]/*[[".buttons[\"Sign Up\"].staticTexts[\"Sign Up\"]",".buttons[\"SignupBtn\"].staticTexts[\"Sign Up\"]",".staticTexts[\"Sign Up\"]"],[[[-1,2],[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/.tap()
        
        key1.tap()
        key0.tap()
        key0.tap()
        key0.tap()
        key0.tap()
        key0.tap()
        key0.tap()
        key0.tap()
        
        app.toolbars["Toolbar"].buttons["Done"].tap()
        elementsQuery/*@START_MENU_TOKEN@*/.staticTexts["Send Code"]/*[[".buttons[\"Send Code\"].staticTexts[\"Send Code\"]",".staticTexts[\"Send Code\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()

    }
 
    func testForgotPassword() throws
    {
                                                        
    }
}
