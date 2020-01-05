/**
 * FluxorSampleToDoTests
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Fluxor
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
