//
//  PreviewTests.swift
//  FluxorSampleToDoTests
//
//  Created by Morten Bjerg Gregersen on 14/12/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

@testable import Fluxor
@testable import FluxorSampleToDo
import XCTest

// These tests only exists for previews not to harm code coverage

class PreviewTests: XCTestCase {
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
