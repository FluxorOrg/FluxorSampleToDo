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
    let reducer = FetchingTodosReducer()

    func testFetchTodosAction() {
        let newState = reducer.reduce(state: AppState(), action: FetchTodosAction())
        XCTAssertTrue(newState.loadingTodos)
        XCTAssertNil(newState.error)
    }

    func testDidFetchTodosAction() {
        let todos = [Todo(title: "Buy milk"), Todo(title: "Walk the dog")]
        let newState = reducer.reduce(state: AppState(), action: DidFetchTodosAction(todos: todos))
        XCTAssertEqual(newState.todos, todos)
        XCTAssertFalse(newState.loadingTodos)
    }

    func testDidFailFetchingTodosAction() {
        let todos = [Todo(title: "Buy milk"), Todo(title: "Walk the dog")]
        let error = "Some error occurred"
        let newState = reducer.reduce(state: AppState(todos: todos), action: DidFailFetchingTodosAction(error: error))
        XCTAssertEqual(newState.todos, [])
        XCTAssertFalse(newState.loadingTodos)
        XCTAssertEqual(newState.error, error)
    }

    func testIrrelevantAction() {
        let state = AppState()
        let newState = reducer.reduce(state: state, action: IrrelevantAction())
        XCTAssertEqual(newState, state)
    }
}

private struct IrrelevantAction: Action {}

extension AppState: Equatable {
    public static func == (lhs: AppState, rhs: AppState) -> Bool {
        return lhs.todos == rhs.todos
            && lhs.loadingTodos == rhs.loadingTodos
            && lhs.error == rhs.error
    }
}
