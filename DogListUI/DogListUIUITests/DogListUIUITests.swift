//
//  DogListUIUITests.swift
//  DogListUIUITests
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

import XCTest

final class DogListUIUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testListAppears() throws {
        let app = XCUIApplication()
        app.launch()
        let element = app.descendants(matching: .any)["DogList"]
        XCTAssertTrue(element.waitForExistence(timeout: 5))
    }

    @MainActor
    func testBackButtonTapTest() throws {
        let app = XCUIApplication()
        app.launch()
        let backButton = app.buttons["BackButton"]
        XCTAssertTrue(backButton.waitForExistence(timeout: 5))
        backButton.tap()
    }

}
