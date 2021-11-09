/*
 * FluxorSampleToDoTests
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

@testable import FluxorSampleToDoSwiftUI
import FluxorTestSupport
import SwiftUI
import ViewInspector
import XCTest

class AddTodoViewTests: ViewTestCase {
    func testAddTodo() throws {
        var view = AddTodoView(store: mockStore)
        let exp = view.on(\.didAppear) { view in
            let form = try view.navigationView().form(0)
            let textField = try form.textField(0)
            try textField.setInput("Buy milk")
            try form.toolbar(0).find(button: "Save").tap()
            XCTAssertEqual(self.mockStore.dispatchedActions[0], HandlingActions.addTodo(payload: "Buy milk"))
        }
        ViewHosting.host(view: view)
        wait(for: [exp], timeout: 0.1)
    }

    func testCancel() throws {
        var view = AddTodoView(store: mockStore)
        let exp = view.on(\.didAppear) { view in
            try view.navigationView().form(0).toolbar(0).find(button: "Cancel").tap()
        }
        ViewHosting.host(view: view)
        wait(for: [exp], timeout: 0.1)
    }

    struct MyDismissAction {
        let dismissExpectation = XCTestExpectation()

        func callAsFunction() {
            dismissExpectation.fulfill()
        }
    }
}

extension AddTodoView: Inspectable {}
