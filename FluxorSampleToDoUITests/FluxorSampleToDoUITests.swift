/**
 * FluxorSampleToDoTests
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import XCTest

class FluxorSampleToDoUITests: XCTestCase {
    func testAddAndDelete() {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
        
        let listPage = ListPage(app: app)
        XCTAssertFalse(listPage.alertIsShown)
        XCTAssertEqual(listPage.numberOfTodods, 4)
        
        // Add todo
        listPage.showAddPage()
            .enterTitle(title: "Buy milk")
            .save()
        XCTAssertEqual(listPage.numberOfTodods, 5)
        
        // Delete todo
        listPage.deleteTodo(title: "Buy milk")
        XCTAssertEqual(listPage.numberOfTodods, 4)
        
        // Cancel adding todo
        listPage.showAddPage().cancel()
    }
    
    func testAlert() {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments = ["-fail-fetching"]
        app.launch()
        
        let listPage = ListPage(app: app)
        XCTAssertTrue(listPage.alertIsShown)
    }
}

struct ListPage {
    let app: XCUIApplication
    
    var numberOfTodods: Int {
        app.tables.buttons.count
    }
    
    var alertIsShown: Bool {
        app.alerts["Error"].exists
    }
    
    func showAddPage() -> AddPage {
        app.navigationBars["Fluxor todos"].buttons["Add"].tap()
        return AddPage(app: app)
    }
    
    func deleteTodo(title: String) {
        let todoCell = app.tables.buttons[title]
        todoCell.swipeLeft()
        app.tables.buttons["trailing0"].tap()
    }
}

struct AddPage {
    let app: XCUIApplication
    
    func enterTitle(title: String) -> Self {
        let textField = app.tables.textFields["Title"]
        textField.tap()
        textField.typeText(title)
        return self
    }
    
    func save() {
        app.navigationBars["Add Todo"].buttons["Save"].tap()
    }
    
    func cancel() {
        app.navigationBars["Add Todo"].buttons["Cancel"].tap()
    }
}
