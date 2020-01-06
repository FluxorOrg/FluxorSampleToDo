/**
 * FluxorSampleToDoTests
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

@testable import Fluxor
@testable import FluxorSampleToDo
import XCTest

class HandlingTodosReducerTests: XCTestCase {
    let reducer = HandlingTodosReducer()

    func testAddTodoAction() {
        let newTodoTitle = "Walk the dog"
        let state = AppState(todos: [Todo(title: "Buy milk")])
        XCTAssertEqual(state.todos.count, 1)
        let newState = reducer.reduce(state: state, action: AddTodoAction(title: newTodoTitle))
        XCTAssertEqual(newState.todos.count, 2)
        XCTAssertEqual(newState.todos[1].title, newTodoTitle)
    }

    func testCompleteTodoAction() {
        let todoToComplete = Todo(title: "Buy milk")
        let otherTodo = Todo(title: "Walk the dog")
        let state = AppState(todos: [todoToComplete, otherTodo])
        XCTAssertFalse(state.todos[0].done)
        let newState = reducer.reduce(state: state, action: CompleteTodoAction(todo: todoToComplete))
        XCTAssertTrue(newState.todos[0].done)
        XCTAssertFalse(newState.todos[1].done)
    }

    func testUncompleteTodoAction() {
        var completedTodo = Todo(title: "Buy milk")
        completedTodo.done = true
        let otherTodo = Todo(title: "Walk the dog")
        let state = AppState(todos: [completedTodo, otherTodo])
        let newState = reducer.reduce(state: state, action: UncompleteTodoAction(todo: completedTodo))
        XCTAssertFalse(newState.todos[0].done)
        XCTAssertFalse(newState.todos[1].done)
    }

    func testDeleteTodoAction() {
        let todoToDelete = Todo(title: "Buy milk")
        let todoToKeep = Todo(title: "Walk the dog")
        let state = AppState(todos: [todoToDelete, todoToKeep])
        XCTAssertEqual(state.todos.count, 2)
        let newState = reducer.reduce(state: state, action: DeleteTodoAction(index: 0))
        XCTAssertEqual(newState.todos.count, 1)
        XCTAssertEqual(newState.todos[0], todoToKeep)
    }

    func testIrrelevantAction() {
        let state = AppState()
        let newState = reducer.reduce(state: state, action: IrrelevantAction())
        XCTAssertEqual(newState, state)
    }
}

private struct IrrelevantAction: Action {}
