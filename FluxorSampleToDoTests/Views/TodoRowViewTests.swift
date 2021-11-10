/*
 * FluxorSampleToDoTests
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

@testable import FluxorSampleToDoSwiftUI
import ViewInspector
import XCTest

class TodoRowViewTests: XCTestCase {
    let todo = Todo(title: "Buy milk")

    func testTitle() throws {
        // Given
        let view = TodoRowView(todo: todo, didSelect: {})
        // Then
        let text = try view.inspect().button().labelView().hStack().text(0)
        XCTAssertEqual(try text.string(), view.todo.title)
    }

    func testUndoneImage() throws {
        // Given
        let view = TodoRowView(todo: todo, didSelect: {})
        // Then
        let image = try view.inspect().button().labelView().hStack().image(2)
        XCTAssertEqual(try image.actualImage().name(), "circle")
    }

    func testDoneImage() throws {
        // Given
        var todo = self.todo
        todo.done = true
        let view = TodoRowView(todo: todo, didSelect: {})
        // Then
        let image = try view.inspect().button().labelView().hStack().image(2)
        XCTAssertEqual(try image.actualImage().name(), "checkmark.circle.fill")
    }

    func testDidSelect() throws {
        // Given
        let expectation = XCTestExpectation(description: debugDescription)
        let view = TodoRowView(todo: todo, didSelect: {
            expectation.fulfill()
        })
        // When
        try view.inspect().button().tap()
        // Then
        wait(for: [expectation], timeout: 5)
    }
}

extension TodoRowView: Inspectable {}
