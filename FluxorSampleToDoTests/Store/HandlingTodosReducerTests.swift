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

class HandlingTodosReducerTests: XCTestCase {
    let reducer = Reducers.handlingTodosReducer

    func testAddTodoAction() {
        let newTodoTitle = "Walk the dog"
        var state = AppState(todos: TodosState(todos: [Todo(title: "Buy milk")]))
        XCTAssertEqual(state.todos.todos.count, 1)
        reducer.reduce(&state, AddTodoAction(title: newTodoTitle))
        XCTAssertEqual(state.todos.todos.count, 2)
        XCTAssertEqual(state.todos.todos[1].title, newTodoTitle)
    }

    func testCompleteTodoAction() {
        let todoToComplete = Todo(title: "Buy milk")
        let otherTodo = Todo(title: "Walk the dog")
        var state = AppState(todos: TodosState(todos: [todoToComplete, otherTodo]))
        XCTAssertFalse(state.todos.todos[0].done)
        reducer.reduce(&state, CompleteTodoAction(todo: todoToComplete))
        XCTAssertTrue(state.todos.todos[0].done)
        XCTAssertFalse(state.todos.todos[1].done)
    }

    func testUncompleteTodoAction() {
        var completedTodo = Todo(title: "Buy milk")
        completedTodo.done = true
        let otherTodo = Todo(title: "Walk the dog")
        var state = AppState(todos: TodosState(todos: [completedTodo, otherTodo]))
        reducer.reduce(&state, UncompleteTodoAction(todo: completedTodo))
        XCTAssertFalse(state.todos.todos[0].done)
        XCTAssertFalse(state.todos.todos[1].done)
    }

    func testDeleteTodoAction() {
        let todoToDelete = Todo(title: "Buy milk")
        let todoToKeep = Todo(title: "Walk the dog")
        var state = AppState(todos: TodosState(todos: [todoToDelete, todoToKeep]))
        XCTAssertEqual(state.todos.todos.count, 2)
        reducer.reduce(&state, DeleteTodoAction(index: 0))
        XCTAssertEqual(state.todos.todos.count, 1)
        XCTAssertEqual(state.todos.todos[0], todoToKeep)
    }

    func testIrrelevantAction() {
        var state = AppState()
        reducer.reduce(&state, IrrelevantAction())
        XCTAssertEqual(state, state)
    }
}

private struct IrrelevantAction: Action {}
