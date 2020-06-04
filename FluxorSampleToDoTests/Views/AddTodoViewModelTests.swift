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
import FluxorTestSupport
import XCTest

class AddTodoViewModelTests: XCTestCase {
    var store: MockStore<AppState, AppEnvironment>!
    var model: AddTodoViewModel!

    override func setUp() {
        super.setUp()
        store = .init(initialState: AppState(), environment: AppEnvironment())
        model = .init(store: store)
    }

    func testAddTodo() {
        // Given
        let title = "Buy milk"
        // When
        model.addTodo(title: title)
        // Then
        let action = store.stateChanges[0].action as! AddTodoAction
        XCTAssertEqual(action.title, title)
    }
}
