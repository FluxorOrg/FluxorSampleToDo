/*
 * FluxorSampleToDoTests
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Fluxor
@testable import FluxorSampleToDoSwiftUI
import FluxorTestSupport
import ViewInspector
import XCTest

final class TodoListViewTests: ViewTestCase {
    let todos = [Todo(title: "Dispatch actions"),
                 { var todo = Todo(title: "Create effects"); todo.done = true; return todo }(),
                 Todo(title: "Select something"),
                 Todo(title: "Intercept everything")]

    func testFetching() throws {
        // Given
        let view = TodoListView(store: mockStore)
        XCTAssertTrue(mockStore.stateChanges.isEmpty)
        // When
        try view.inspect().list().callOnAppear()
        // Then
        XCTAssertEqual(mockStore.dispatchedActions[0], FetchingActions.fetchTodos())
    }

    func testLoading() throws {
        // Given
        mockStore.overrideSelector(TodosSelectors.isLoadingTodos, value: true)
        let view = TodoListView(store: mockStore)
        // Then
        let hStack = try view.inspect().list().hStack(0)
        XCTAssertNoThrow(try hStack.progressView(0))
        let text = try hStack.text(1)
        XCTAssertEqual(try text.string(), "Loading todos...")
    }

    func testTodos() throws {
        // Given
        mockStore.overrideSelector(TodosSelectors.getTodos, value: todos)
        let view = TodoListView(store: mockStore)
        // Then
        let row1 = try view.inspect().list().forEach(0).view(TodoRowView.self, 0).actualView()
        XCTAssertEqual(row1.todo, todos[0])
    }

    func testNoTodos() throws {
        // Given
        let view = TodoListView(store: mockStore)
        // Then
        let text = try view.inspect().list().text(0)
        XCTAssertEqual(try text.string(), "No todos")
    }

    func testToggleTodo() throws {
        // Given
        mockStore.overrideSelector(TodosSelectors.getTodos, value: todos)
        let view = TodoListView(store: mockStore)
        let forEach = try view.inspect().list().forEach(0)
        // When
        let row1 = try forEach.view(TodoRowView.self, 0).actualView()
        row1.didSelect()
        // Then
        XCTAssertEqual(mockStore.dispatchedActions[0], HandlingActions.completeTodo(payload: todos[0]))
        // When
        let row2 = try forEach.view(TodoRowView.self, 1).actualView()
        row2.didSelect()
        // Then
        XCTAssertEqual(mockStore.dispatchedActions[1], HandlingActions.uncompleteTodo(payload: todos[1]))
    }

    func testDeleteTodo() throws {
        // Given
        mockStore.overrideSelector(TodosSelectors.getTodos, value: todos)
        let view = TodoListView(store: mockStore)
        let forEach = try view.inspect().list().forEach(0)
        // When
        try forEach.callOnDelete(IndexSet(integer: 0))
        // Then
        XCTAssertEqual(mockStore.dispatchedActions[0], HandlingActions.deleteTodo(payload: 0))
    }
}

extension TodoListView: Inspectable {}
