//
//  ReducersTests.swift
//  FluxorSampleToDoTests
//
//  Created by Morten Bjerg Gregersen on 28/11/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

@testable import Fluxor
@testable import FluxorSampleToDo
import XCTest

class ReducersHandlingTodosReducerTests: XCTestCase {
    let reducer = Reducers.handlingTodosReducer
    
    func testAddTodoAction() {
        let newTodoTitle = "Walk the dog"
        let state = AppState(todos: [Todo(title: "Buy milk")])
        XCTAssertEqual(state.todos.count, 1)
        let newState = reducer.reduce(state, AddTodoAction(title: newTodoTitle))
        XCTAssertEqual(newState.todos.count, 2)
        XCTAssertEqual(newState.todos[1].title, newTodoTitle)
    }

    func testCompleteTodoAction() {
        let todoToComplete = Todo(title: "Buy milk")
        let otherTodo = Todo(title: "Walk the dog")
        let state = AppState(todos: [todoToComplete, otherTodo])
        XCTAssertFalse(state.todos[0].done)
        let newState = reducer.reduce(state, CompleteTodoAction(todo: todoToComplete))
        XCTAssertTrue(newState.todos[0].done)
        XCTAssertFalse(newState.todos[1].done)
    }

    func testUncompleteTodoAction() {
        var completedTodo = Todo(title: "Buy milk")
        completedTodo.done = true
        let otherTodo = Todo(title: "Walk the dog")
        let state = AppState(todos: [completedTodo, otherTodo])
        let newState = reducer.reduce(state, UncompleteTodoAction(todo: completedTodo))
        XCTAssertFalse(newState.todos[0].done)
        XCTAssertFalse(newState.todos[1].done)
    }
    
    func testDeleteTodoAction() {
        let todoToDelete = Todo(title: "Buy milk")
        let todoToKeep = Todo(title: "Walk the dog")
        let state = AppState(todos: [todoToDelete, todoToKeep])
        XCTAssertEqual(state.todos.count, 2)
        let newState = reducer.reduce(state, DeleteTodoAction(offsets: IndexSet(arrayLiteral: 0)))
        XCTAssertEqual(newState.todos.count, 1)
        XCTAssertEqual(newState.todos[0], todoToKeep)
    }

    func testIrrelevantAction() {
        let state = AppState()
        let newState = reducer.reduce(state, IrrelevantAction())
        XCTAssertEqual(newState, state)
    }
}

fileprivate struct IrrelevantAction: Action {}
