/*
 * FluxorSampleToDoTests
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

#if SWIFTUI
@testable import FluxorSampleToDoSwiftUI
#else
@testable import FluxorSampleToDoUIKit
#endif
import XCTest

class TodoServiceTests: XCTestCase {
    func testFetchTodos() {
        // Given
        let todos = [Todo(title: "Buy milk")]
        let jsonData = try! JSONEncoder().encode(todos)
        let json = String(data: jsonData, encoding: .utf8)!
        URLProtocolMock.responseByPath["/MortenGregersen/FluxorSampleToDo/master/todos.json"] = (200, json)
        let todoService = TodoService(urlSession: URLSession.sessionWithMock)
        let expectation = XCTestExpectation(description: debugDescription)
        // When
        let cancellable = todoService.fetchTodos()
            .sink(receiveCompletion: { _ in },
                  receiveValue: { fetchedTodos in
                      XCTAssertEqual(fetchedTodos, todos)
                      expectation.fulfill()
            })
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(cancellable)
    }
}
