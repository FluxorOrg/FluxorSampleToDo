//
//  AddTodoViewModelTests.swift
//  FluxorSampleToDoTests
//
//  Created by Morten Bjerg Gregersen on 04/12/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

@testable import Fluxor
@testable import FluxorSampleToDo
import XCTest

class AddTodoViewModelTests: XCTestCase {
    var testStore: Store<AppState>!
    var storeInterceptor: TestStoreInterceptor<AppState>!
    var viewModel: AddTodoViewModel!

    override func setUp() {
        super.setUp()
        storeInterceptor = TestStoreInterceptor<AppState>()
        testStore = Store(initialState: AppState())
        testStore.register(interceptor: storeInterceptor)
        viewModel = AddTodoViewModel(store: testStore)
    }

    func testAddTodo() {
        // Given
        let title = "Buy milk"
        // When
        viewModel.addTodo(title: title)
        // Then
        let action = storeInterceptor.dispatchedActionsAndStates[0].action as! AddTodoAction
        XCTAssertEqual(action.title, title)
    }
}
