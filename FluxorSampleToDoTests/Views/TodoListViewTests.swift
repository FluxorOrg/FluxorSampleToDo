//
//  TodoListViewTests.swift
//  FluxorSampleToDoTests
//
//  Created by Morten Bjerg Gregersen on 12/12/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

@testable import Fluxor
@testable import FluxorSampleToDo
@testable import ViewInspector
import XCTest

class TodoListViewTests: XCTestCase {
    let todos = [Todo(title: "Dispatch actions"),
                 Todo(title: "Create effects"),
                 Todo(title: "Select something"),
                 Todo(title: "Intercept everything")]

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
        let row1 = try view.inspect().list().forEach(0).view(TodoRowView.self, 0).actualView()
        row1.didSelect()
        XCTAssertEqual(viewModel.toggledTodo, todos[0])
    }
}

fileprivate class MockViewModel: TodoListView.Model {
    var toggledTodo: Todo?
    
    override func toggle(todo: Todo) {
        super.toggle(todo: todo)
        toggledTodo = todo
    }
}

extension TodoListView: Inspectable {}
extension ActivityIndicator: Inspectable {}
