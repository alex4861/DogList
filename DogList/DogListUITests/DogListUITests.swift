//
//  DogListUITests.swift
//  DogListUITests
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

import XCTest

final class DogListUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testListAppears() throws{
        let app = XCUIApplication()
        app.launch()

        let cell = app.tables.cells.element(boundBy: 0)
        XCTAssertTrue(cell.waitForExistence(timeout: 3))
    }

}
