/**
 * FluxorSampleToDoTests
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

@testable import Fluxor
@testable import FluxorSampleToDoSwiftUI
import XCTest

// These tests only exists for previews not to harm code coverage

class PreviewTests: XCTestCase {
    func testRootViewPreview() {
        XCTAssertTrue(RootView_Previews.previews is RootView)
    }
    
    func testTodoListViewPreview() {
        let preview = TodoListView_Previews.previews as! TodoListView
        XCTAssertEqual(preview.model.store.state, previewStore.state)
    }

    func testAddTodoViewPreview() {
        let preview = AddTodoView_Previews.previews as! AddTodoView
        XCTAssertEqual(preview.model.store.state, previewStore.state)
    }

    func testTodoRowViewPreview() throws {
        let preview = TodoRowView_Previews.previews as! TodoRowView
        try preview.inspect().button().tap()
        XCTAssertEqual(preview.todo.title, "Buy milk")
    }
}
