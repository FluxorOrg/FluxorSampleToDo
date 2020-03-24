/**
 * FluxorSampleToDoTests
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

@testable import Fluxor
#if SWIFTUI
@testable import FluxorSampleToDoSwiftUI
#else
@testable import FluxorSampleToDoUIKit
#endif
import XCTest

class FetchingTodosReducerTests: XCTestCase {
    let reducer = Reducers.fetchingTodosReducer

    func testFetchTodosAction() {
        var state = AppState()
        reducer.reduce(&state, FetchTodosAction())
        XCTAssertTrue(state.todos.loadingTodos)
        XCTAssertNil(state.todos.error)
    }

    func testDidFetchTodosAction() {
        var state = AppState()
        let todos = [Todo(title: "Buy milk"), Todo(title: "Walk the dog")]
        reducer.reduce(&state, DidFetchTodosAction(todos: todos))
        XCTAssertEqual(state.todos.todos, todos)
        XCTAssertFalse(state.todos.loadingTodos)
    }

    func testDidFailFetchingTodosAction() {
        let todos = [Todo(title: "Buy milk"), Todo(title: "Walk the dog")]
        var state = AppState(todos: TodosState(todos: todos))
        let error = "Some error occurred"
        reducer.reduce(&state, DidFailFetchingTodosAction(error: error))
        XCTAssertEqual(state.todos.todos, [])
        XCTAssertFalse(state.todos.loadingTodos)
        XCTAssertEqual(state.todos.error, error)
    }

    func testIrrelevantAction() {
        var state = AppState()
        reducer.reduce(&state, IrrelevantAction())
        XCTAssertEqual(state, state)
    }
}

private struct IrrelevantAction: Action {}

extension AppState: Equatable {
    public static func == (lhs: AppState, rhs: AppState) -> Bool {
        return lhs.todos == rhs.todos
    }
}

extension TodosState: Equatable {
    public static func == (lhs: TodosState, rhs: TodosState) -> Bool {
        return lhs.todos == rhs.todos
            && lhs.loadingTodos == rhs.loadingTodos
            && lhs.error == rhs.error
    }
}
