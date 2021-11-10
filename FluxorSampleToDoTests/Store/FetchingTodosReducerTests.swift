/*
 * FluxorSampleToDoTests
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Fluxor
#if SWIFTUI
@testable import FluxorSampleToDoSwiftUI
#else
@testable import FluxorSampleToDoUIKit
#endif
import XCTest

class FetchingTodosReducerTests: XCTestCase {
    let reducer = todoReducer

    func testFetchTodosAction() {
        var state = TodoState()
        reducer.reduce(&state, FetchingActions.fetchTodos())
        XCTAssertTrue(state.loadingTodos)
        XCTAssertNil(state.error)
    }

    func testDidFetchTodosAction() {
        var state = TodoState()
        let todos = [Todo(title: "Buy milk"), Todo(title: "Walk the dog")]
        reducer.reduce(&state, FetchingActions.didFetchTodos(payload: todos))
        XCTAssertEqual(state.todos, todos)
        XCTAssertFalse(state.loadingTodos)
    }

    func testDidFailFetchingTodosAction() {
        let todos = [Todo(title: "Buy milk"), Todo(title: "Walk the dog")]
        var state = TodoState(todos: todos)
        let error = "Some error occurred"
        reducer.reduce(&state, FetchingActions.didFailFetchingTodos(payload: error))
        XCTAssertEqual(state.todos, [])
        XCTAssertFalse(state.loadingTodos)
        XCTAssertEqual(state.error, error)
    }

    func testDismissErrorAction() {
        var state = TodoState(error: "Some error occurred")
        reducer.reduce(&state, FetchingActions.dismissError())
        XCTAssertNil(state.error)
    }

    func testIrrelevantAction() {
        var state = TodoState()
        reducer.reduce(&state, IrrelevantAction())
        XCTAssertEqual(state, state)
    }
}

private struct IrrelevantAction: Action {}

extension TodoState: Equatable {
    public static func == (lhs: TodoState, rhs: TodoState) -> Bool {
        lhs.todos == rhs.todos
            && lhs.loadingTodos == rhs.loadingTodos
            && lhs.error == rhs.error
    }
}
