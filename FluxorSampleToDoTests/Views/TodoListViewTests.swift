/**
 * FluxorSampleToDoTests
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Fluxor
@testable import FluxorSampleToDo
import ViewInspector
import XCTest

class TodoListViewTests: XCTestCase {
    let todos = [Todo(title: "Dispatch actions"),
                 { var todo = Todo(title: "Create effects"); todo.done = true; return todo }(),
                 Todo(title: "Select something"),
                 Todo(title: "Intercept everything")]

    func testFetching() throws {
        let viewModel = MockViewModel()
        let view = TodoListView(model: viewModel, loading: true)
        XCTAssertFalse(viewModel.didFetchTodos)
        try view.inspect().list().callOnAppear()
        XCTAssertTrue(viewModel.didFetchTodos)
    }

    func testLoading() throws {
        let view = TodoListView(loading: true)
        let hStack = try view.inspect().list().hStack(0)
        XCTAssertNoThrow(try hStack.view(ActivityIndicator.self, 0))
        let text = try hStack.text(1)
        XCTAssertEqual(try text.string(), "Loading todos...")
    }

    func testTodos() throws {
        let view = TodoListView(todos: todos)
        let row1 = try view.inspect().list().forEach(0).view(TodoRowView.self, 0).actualView()
        XCTAssertEqual(row1.todo, todos[0])
    }

    func testNoTodos() throws {
        let view = TodoListView()
        let text = try view.inspect().list().text(0)
        XCTAssertEqual(try text.string(), "No todos")
    }

    func testToggleTodo() throws {
        let viewModel = MockViewModel()
        let view = TodoListView(model: viewModel, todos: todos)
        let forEach = try view.inspect().list().forEach(0)
        let row1 = try forEach.view(TodoRowView.self, 0).actualView()
        row1.didSelect()
        XCTAssertEqual(viewModel.toggledTodo, todos[0])
        let row2 = try forEach.view(TodoRowView.self, 1).actualView()
        row2.didSelect()
        XCTAssertEqual(viewModel.toggledTodo, todos[1])
    }
}

private class MockViewModel: TodoListView.Model {
    var didFetchTodos = false
    var toggledTodo: Todo?

    override func fetchTodos() {
        didFetchTodos = true
    }

    override func toggle(todo: Todo) {
        toggledTodo = todo
    }
}

extension TodoListView: Inspectable {}
extension ActivityIndicator: Inspectable {}
