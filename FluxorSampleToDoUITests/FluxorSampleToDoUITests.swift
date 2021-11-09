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
        
        // Wait for spinner to disappear
        let spinner = app.activityIndicators.firstMatch
        let exists = NSPredicate(format: "exists == false")
        expectation(for: exists, evaluatedWith: spinner, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        
        let listPage = ListPage(app: app)
        XCTAssertFalse(listPage.alertIsShown)
        XCTAssertEqual(listPage.numberOfTodos, 4)

        // Add todo
        listPage.showAddPage()
            .enterTitle(title: "Buy milk")
            .save()
        XCTAssertEqual(listPage.numberOfTodos, 5)

        // Delete todo
        listPage.deleteTodo(title: "Buy milk")
        XCTAssertEqual(listPage.numberOfTodos, 4)

        // Cancel adding todo
        listPage.showAddPage().cancel()
        
        // Complete todo
        listPage.tapTodo(at: 1)
        XCTAssertEqual(listPage.numberOfCompletedTodos, 1)
        
        // Uncomplete todo
        listPage.tapTodo(at: 1)
        XCTAssertEqual(listPage.numberOfCompletedTodos, 0)
    }
    
    func testAlert() {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launchArguments = ["-fail-fetching"]
        app.launch()
        
        // Wait for spinner to disappear
        let spinner = app.activityIndicators.firstMatch
        let exists = NSPredicate(format: "exists == false")
        expectation(for: exists, evaluatedWith: spinner, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)
        
        // See error alert
        let listPage = ListPage(app: app)
        XCTAssertTrue(listPage.alertIsShown)
        
        // Dismiss error alert
        listPage.dismissAlert()
    }
}

struct ListPage {
    let app: XCUIApplication
    
    var numberOfTodos: Int {
        return app.collectionViews.cells.count
    }
    
    var numberOfCompletedTodos: Int {
        return app.collectionViews.cells.matching(NSPredicate(format: "value == 'checked'")).count
    }
    
    var alertIsShown: Bool {
        app.alerts["Error"].exists
    }
    
    func showAddPage() -> AddPage {
        app.navigationBars["Fluxor Todos"].buttons["Add"].tap()
        return AddPage(app: app)
    }
    
    func tapTodo(at index: Int) {
        let todoCell = app.collectionViews.cells.element(boundBy: index)
        todoCell.tap()
    }
    
    func deleteTodo(title: String) {
        let todoCell = app.collectionViews.cells.staticTexts[title]
        todoCell.swipeLeft()
        app.collectionViews.buttons["Delete"].tap()
    }
    
    func dismissAlert() {
        app.alerts["Error"].buttons["OK"].tap()
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
