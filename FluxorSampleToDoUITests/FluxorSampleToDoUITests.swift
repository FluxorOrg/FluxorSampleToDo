//
//  FluxorSampleToDoUITests.swift
//  FluxorSampleToDoUITests
//
//  Created by Morten Bjerg Gregersen on 14/12/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

import XCTest

class FluxorSampleToDoUITests: XCTestCase {
    func testAddAndDelete() {
        continueAfterFailure = false
        let app = XCUIApplication()
        app.launch()
        
        let listPage = ListPage(app: app)
        XCTAssertEqual(listPage.numberOfTodods, 0)
        
        // Add todo
        listPage.showAddPage()
            .enterTitle(title: "Buy milk")
            .save()
        XCTAssertEqual(listPage.numberOfTodods, 1)
        
        // Delete todo
        listPage.deleteTodo(title: "Buy milk")
        XCTAssertEqual(listPage.numberOfTodods, 0)
        
        // Cancel adding todo
        listPage.showAddPage().cancel()
    }
}

struct ListPage {
    let app: XCUIApplication
    
    var numberOfTodods: Int {
        app.tables.buttons.count
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
