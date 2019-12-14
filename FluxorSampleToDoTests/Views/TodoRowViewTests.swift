//
//  TodoRowViewTests.swift
//  FluxorSampleToDoTests
//
//  Created by Morten Bjerg Gregersen on 13/12/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

@testable import FluxorSampleToDo
import ViewInspector
import XCTest

class TodoRowViewTests: XCTestCase {
    let todo = Todo(title: "Buy milk")

    func testTitle() throws {
        let view = TodoRowView(todo: todo, didSelect: {})
        let text = try view.inspect().button().hStack().text(0)
        XCTAssertEqual(try text.string(), view.todo.title)
    }

    func testUndoneImage() throws {
        let view = TodoRowView(todo: todo, didSelect: {})
        let image = try view.inspect().button().hStack().image(2)
        XCTAssertEqual(try image.imageName()!, "circle")
    }

    func testDoneImage() throws {
        var todo = self.todo
        todo.done = true
        let view = TodoRowView(todo: todo, didSelect: {})
        let image = try view.inspect().button().hStack().image(2)
        XCTAssertEqual(try image.imageName()!, "checkmark.circle.fill")
    }

    func testDidSelect() throws {
        let expectation = XCTestExpectation(description: debugDescription)
        let view = TodoRowView(todo: todo, didSelect: {
            expectation.fulfill()
        })
        try view.inspect().button().tap()
        wait(for: [expectation], timeout: 5)
    }
}

extension TodoRowView: Inspectable {}
