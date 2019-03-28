//
//  KivraTaskUITests.swift
//  KivraTaskUITests
//
//  Created by Ramon Vasconcelos on 28/03/2019.
//  Copyright © 2019 Ramon Vasconcelos. All rights reserved.
//

import XCTest

class KivraTaskUITests: XCTestCase {

    override func setUp() {
        continueAfterFailure = true
        XCUIApplication().launch()
    }

    func login() {
        let app = XCUIApplication()
        app.textFields["email"].tap()
        if (app.textFields["email"].value as! String) == "email" {
            app.textFields["email"].typeText("ramon@kivra.fi")
        }
        app.secureTextFields["password"].tap()
        app.secureTextFields["password"].typeText("321helloWORLD")

        app.buttons["Authenticate"].tap()
    }

    func testEmailTextField() {
        let app = XCUIApplication()
        XCTAssert(app.textFields["email"].exists)
    }

    func testPasswordTextField() {
        let app = XCUIApplication()
        XCTAssert(app.secureTextFields["password"].exists)
    }

    func testAuthenticateButton() {
        let app = XCUIApplication()
        XCTAssert(app.buttons["Authenticate"].exists)
    }

    func testUserAuthenticationFlow() {
        login()
        let app = XCUIApplication()
        let messageCell = app.cells.firstMatch.exists
        let exists = NSPredicate(format: "exists == true")

        let expectation = XCTNSPredicateExpectation(predicate: exists, object: messageCell)
        _ = XCTWaiter.wait(for: [expectation], timeout: 5.0)

    }

    func testTableViewRefresh() {
        login()
        sleep(1)
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.cells.firstMatch.swipeDown()

        let moreThanZeroCells = NSPredicate(format: "count > 0")
        let expectation = XCTNSPredicateExpectation(predicate: moreThanZeroCells, object: tablesQuery.cells)
        _ = XCTWaiter.wait(for: [expectation], timeout: 5.0)

    }

    func testCellDeletion() {
        login()
        sleep(1)
        let app = XCUIApplication()
        let tablesQuery = app.tables
        let originalNumberOfCells = tablesQuery.cells.count

        tablesQuery.cells.firstMatch.swipeLeft()
        tablesQuery.buttons["Delete"].tap()

        let newNumberOfCells = tablesQuery.cells.count

        XCTAssert(newNumberOfCells == originalNumberOfCells - 1)
    }

}
