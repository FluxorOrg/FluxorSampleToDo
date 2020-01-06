/**
 * FluxorSampleToDoTests
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Combine
import Fluxor
@testable import FluxorSampleToDoSwiftUI
import XCTest

class EffectsTests: XCTestCase {
    @Published private var action: Action = InitialTestAction()

    func testFetchTodosSuccess() {
        // Given
        let expectation = XCTestExpectation(description: debugDescription)
        Current.todoService = TodoServiceMock(shouldSucceed: true)
        let effects = TodosEffects($action)
        guard case .dispatching(let fetchTodos) = effects.fetchTodos else { XCTFail(); return }
        let cancellable = fetchTodos.sink { action in
            guard let didFetchTodosAction = action as? DidFetchTodosAction else { return }
            XCTAssertEqual(didFetchTodosAction.todos.count, 4)
            expectation.fulfill()
        }
        // When
        action = FetchTodosAction()
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(cancellable)
    }

    func testFetchTodosFailure() {
        // Given
        let expectation = XCTestExpectation(description: debugDescription)
        Current.todoService = TodoServiceMock(shouldSucceed: false)
        let effects = TodosEffects($action)
        guard case .dispatching(let fetchTodos) = effects.fetchTodos else { XCTFail(); return }
        let cancellable = fetchTodos.sink { action in
            guard let didFailFetchingTodosAction = action as? DidFailFetchingTodosAction else { return }
            XCTAssertEqual(didFailFetchingTodosAction.error, "Something bad happened, and the todos could not be fetched.")
            expectation.fulfill()
        }
        // When
        action = FetchTodosAction()
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertNotNil(cancellable)
    }
}

private struct InitialTestAction: Action {}

private class TodoServiceMock: TodoServiceProtocol {
    let shouldSucceed: Bool

    init(shouldSucceed: Bool) {
        self.shouldSucceed = shouldSucceed
    }

    func fetchTodos() -> AnyPublisher<[Todo], Error> {
        let publisher: Result<[Todo], Error>.Publisher
        if shouldSucceed {
            publisher = .init(.success([
                Todo(title: "Dispatch actions"),
                Todo(title: "Create effects"),
                Todo(title: "Select something"),
                Todo(title: "Intercept everything"),
            ]))
        } else {
            publisher = .init(URLError(.badServerResponse))
        }
        return publisher.eraseToAnyPublisher()
    }
}
