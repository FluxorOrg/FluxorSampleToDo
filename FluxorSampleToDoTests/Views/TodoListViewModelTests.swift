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
    var testStore: Store<AppState>!
    var storeInterceptor: TestStoreInterceptor<AppState>!
    var viewModel: TodoListViewModel!

    override func setUp() {
        super.setUp()
        storeInterceptor = TestStoreInterceptor<AppState>()
        testStore = Store(initialState: AppState())
        testStore.register(interceptor: storeInterceptor)
        viewModel = TodoListViewModel(store: testStore)
    }

    func testFetchTodos() {
        // When
        viewModel.fetchTodos()
        // Then
        XCTAssertNotNil(storeInterceptor.dispatchedActionsAndStates[0].action as? FetchTodosAction)
    }

    func testToggleIncompleteTodo() {
        // Given
        let todo = Todo(title: "Buy milk")
        // When
        viewModel.toggle(todo: todo)
        // Then
        let action = storeInterceptor.dispatchedActionsAndStates[0].action as! CompleteTodoAction
        XCTAssertEqual(action.todo, todo)
    }

    func testToggleCompleteTodo() {
        // Given
        var todo = Todo(title: "Buy milk")
        todo.done = true
        // When
        viewModel.toggle(todo: todo)
        // Then
        let action = storeInterceptor.dispatchedActionsAndStates[0].action as! UncompleteTodoAction
        XCTAssertEqual(action.todo, todo)
    }

    func testDelete() {
        // Given
        let offsets = IndexSet(arrayLiteral: 1)
        // When
        viewModel.delete(at: offsets)
        // Then
        let action = storeInterceptor.dispatchedActionsAndStates[0].action as! DeleteTodoAction
        XCTAssertEqual(action.offsets, offsets)
    }
}
