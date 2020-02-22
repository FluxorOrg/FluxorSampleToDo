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
        let state = AppState(todos: TodosState(todos: [Todo(title: "Buy milk")]))
        XCTAssertEqual(state.todos.todos.count, 1)
        let newState = reducer.reduce(state: state, action: AddTodoAction(title: newTodoTitle))
        XCTAssertEqual(newState.todos.todos.count, 2)
        XCTAssertEqual(newState.todos.todos[1].title, newTodoTitle)
    }

    func testCompleteTodoAction() {
        let todoToComplete = Todo(title: "Buy milk")
        let otherTodo = Todo(title: "Walk the dog")
        let state = AppState(todos: TodosState(todos: [todoToComplete, otherTodo]))
        XCTAssertFalse(state.todos.todos[0].done)
        let newState = reducer.reduce(state: state, action: CompleteTodoAction(todo: todoToComplete))
        XCTAssertTrue(newState.todos.todos[0].done)
        XCTAssertFalse(newState.todos.todos[1].done)
    }

    func testUncompleteTodoAction() {
        var completedTodo = Todo(title: "Buy milk")
        completedTodo.done = true
        let otherTodo = Todo(title: "Walk the dog")
        let state = AppState(todos: TodosState(todos: [completedTodo, otherTodo]))
        let newState = reducer.reduce(state: state, action: UncompleteTodoAction(todo: completedTodo))
        XCTAssertFalse(newState.todos.todos[0].done)
        XCTAssertFalse(newState.todos.todos[1].done)
    }

    func testDeleteTodoAction() {
        let todoToDelete = Todo(title: "Buy milk")
        let todoToKeep = Todo(title: "Walk the dog")
        let state = AppState(todos: TodosState(todos: [todoToDelete, todoToKeep]))
        XCTAssertEqual(state.todos.todos.count, 2)
        let newState = reducer.reduce(state: state, action: DeleteTodoAction(index: 0))
        XCTAssertEqual(newState.todos.todos.count, 1)
        XCTAssertEqual(newState.todos.todos[0], todoToKeep)
    }

    func testIrrelevantAction() {
        let state = AppState()
        let newState = reducer.reduce(state: state, action: IrrelevantAction())
        XCTAssertEqual(newState, state)
    }
}

private struct IrrelevantAction: Action {}
