/**
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
import FluxorTestSupport
import XCTest

class TodoListViewModelTests: XCTestCase {
    var store: MockStore<AppState, AppEnvironment>!
    var model: TodoListViewModel!

    override func setUp() {
        super.setUp()
        store = .init(initialState: AppState(), environment: AppEnvironment())
        model = .init(store: store)
    }

    func testFetchTodos() {
        // When
        model.fetchTodos()
        // Then
        XCTAssertNotNil(store.stateChanges[0].action as? FetchTodosAction)
    }

    func testToggleUncompleteTodo() {
        // Given
        let todo = Todo(title: "Buy milk")
        // When
        model.toggle(todo: todo)
        // Then
        let action = store.stateChanges[0].action as! CompleteTodoAction
        XCTAssertEqual(action.todo, todo)
    }

    func testToggleCompleteTodo() {
        // Given
        var todo = Todo(title: "Buy milk")
        todo.done = true
        // When
        model.toggle(todo: todo)
        // Then
        let action = store.stateChanges[0].action as! UncompleteTodoAction
        XCTAssertEqual(action.todo, todo)
    }

    func testDelete() {
        // Given
        let index = 1
        // When
        model.delete(at: index)
        // Then
        let action = store.stateChanges[0].action as! DeleteTodoAction
        XCTAssertEqual(action.index, index)
    }
}
