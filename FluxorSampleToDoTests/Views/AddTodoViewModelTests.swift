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
    var store: Store<AppState>!
    var storeInterceptor: TestStoreInterceptor<AppState>!
    var model: AddTodoView.Model!
    
    override func setUp() {
        super.setUp()
        storeInterceptor = .init()
        store = .init(initialState: AppState())
        store.register(interceptor: storeInterceptor)
        model = .init(store: store)
    }

    func testAddTodo() {
        // Given
        let title = "Buy milk"
        // When
        model.addTodo(title: title)
        // Then
        let action = storeInterceptor.dispatchedActionsAndStates[0].action as! AddTodoAction
        XCTAssertEqual(action.title, title)
    }
}
