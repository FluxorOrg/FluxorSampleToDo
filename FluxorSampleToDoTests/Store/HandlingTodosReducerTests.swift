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
import XCTest

class HandlingTodosReducerTests: XCTestCase {
    let reducer = todoReducer

    func testAddTodoAction() {
        let newTodoTitle = "Walk the dog"
        var state = TodoState(todos: [Todo(title: "Buy milk")])
        XCTAssertEqual(state.todos.count, 1)
        reducer.reduce(&state, HandlingActions.addTodo(payload: newTodoTitle))
        XCTAssertEqual(state.todos.count, 2)
        XCTAssertEqual(state.todos[1].title, newTodoTitle)
    }

    func testCompleteTodoAction() {
        let todoToComplete = Todo(title: "Buy milk")
        let otherTodo = Todo(title: "Walk the dog")
        var state = TodoState(todos: [todoToComplete, otherTodo])
        XCTAssertFalse(state.todos[0].done)
        reducer.reduce(&state, HandlingActions.completeTodo(payload: todoToComplete))
        XCTAssertTrue(state.todos[0].done)
        XCTAssertFalse(state.todos[1].done)
    }

    func testUncompleteTodoAction() {
        var completedTodo = Todo(title: "Buy milk")
        completedTodo.done = true
        let otherTodo = Todo(title: "Walk the dog")
        var state = TodoState(todos: [completedTodo, otherTodo])
        reducer.reduce(&state, HandlingActions.uncompleteTodo(payload: completedTodo))
        XCTAssertFalse(state.todos[0].done)
        XCTAssertFalse(state.todos[1].done)
    }

    func testDeleteTodoAction() {
        let todoToDelete = Todo(title: "Buy milk")
        let todoToKeep = Todo(title: "Walk the dog")
        var state = TodoState(todos: [todoToDelete, todoToKeep])
        XCTAssertEqual(state.todos.count, 2)
        reducer.reduce(&state, HandlingActions.deleteTodo(payload: 0))
        XCTAssertEqual(state.todos.count, 1)
        XCTAssertEqual(state.todos[0], todoToKeep)
    }

    func testIrrelevantAction() {
        var state = TodoState()
        reducer.reduce(&state, IrrelevantAction())
        XCTAssertEqual(state, state)
    }
}

private struct IrrelevantAction: Action {}
