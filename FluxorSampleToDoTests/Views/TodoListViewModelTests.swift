//
//  TodoListViewModelTests.swift
//  FluxorSampleToDoTests
//
//  Created by Morten Bjerg Gregersen on 04/12/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

@testable import Fluxor
@testable import FluxorSampleToDo
import XCTest

class TodoListViewModelTests: XCTestCase {
    var store: Store<AppState>!
    var storeInterceptor: TestStoreInterceptor<AppState>!
    var model: TodoListView.Model!

    override func setUp() {
        super.setUp()
        storeInterceptor = .init()
        store = .init(initialState: AppState())
        store.register(interceptor: storeInterceptor)
        model = .init(store: store)
    }

    func testFetchTodos() {
        // When
        model.fetchTodos()
        // Then
        XCTAssertNotNil(storeInterceptor.dispatchedActionsAndStates[0].action as? FetchTodosAction)
    }

    func testToggleIncompleteTodo() {
        // Given
        let todo = Todo(title: "Buy milk")
        // When
        model.toggle(todo: todo)
        // Then
        let action = storeInterceptor.dispatchedActionsAndStates[0].action as! CompleteTodoAction
        XCTAssertEqual(action.todo, todo)
    }

    func testToggleCompleteTodo() {
        // Given
        var todo = Todo(title: "Buy milk")
        todo.done = true
        // When
        model.toggle(todo: todo)
        // Then
        let action = storeInterceptor.dispatchedActionsAndStates[0].action as! UncompleteTodoAction
        XCTAssertEqual(action.todo, todo)
    }

    func testDelete() {
        // Given
        let offsets = IndexSet(arrayLiteral: 1)
        // When
        model.delete(at: offsets)
        // Then
        let action = storeInterceptor.dispatchedActionsAndStates[0].action as! DeleteTodoAction
        XCTAssertEqual(action.offsets, offsets)
    }
}
