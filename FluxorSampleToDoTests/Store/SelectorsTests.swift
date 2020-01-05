/**
 * FluxorSampleToDoTests
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

@testable import FluxorSampleToDo
import XCTest

class SelectorsTests: XCTestCase {
    let state = AppState(todos: [Todo(title: "Dispatch actions"),
                                 Todo(title: "Create effects"),
                                 Todo(title: "Select something"),
                                 Todo(title: "Intercept everything")],
                         loadingTodos: true,
                         error: "Some error")

    func testGetTodos() {
        XCTAssertEqual(Selectors.getTodos(state), state.todos)
    }

    func testIsLoadingTotods() {
        XCTAssertEqual(Selectors.isLoadingTodos(state), state.loadingTodos)
    }

    func testGetError() {
        XCTAssertEqual(Selectors.getError(state), state.error)
    }

    func testShouldShowError() {
        XCTAssertEqual(Selectors.shouldShowError(state), true)
    }
}
