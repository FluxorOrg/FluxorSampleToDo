/**
 * FluxorSampleToDoTests
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

#if SWIFTUI
@testable import FluxorSampleToDoSwiftUI
#else
@testable import FluxorSampleToDoUIKit
#endif
import XCTest

class SelectorsTests: XCTestCase {
    let state = TodoState(todos: [Todo(title: "Dispatch actions"),
                                   Todo(title: "Create effects"),
                                   Todo(title: "Select something"),
                                   Todo(title: "Intercept everything")],
                           loadingTodos: true,
                           error: "Some error")

    func testGetTodos() {
        XCTAssertEqual(TodosSelectors.getTodos.projector(state), state.todos)
    }

    func testIsLoadingTotods() {
        XCTAssertEqual(TodosSelectors.isLoadingTodos.projector(state), state.loadingTodos)
    }

    func testGetError() {
        XCTAssertEqual(TodosSelectors.getError.projector(state), state.error)
    }
}
