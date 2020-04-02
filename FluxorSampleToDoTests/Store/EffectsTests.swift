/**
 * FluxorSampleToDoTests
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Combine
import Fluxor
import FluxorTestSupport
#if SWIFTUI
@testable import FluxorSampleToDoSwiftUI
#else
@testable import FluxorSampleToDoUIKit
#endif
import XCTest

class EffectsTests: XCTestCase {
    private let effects = TodosEffects()

    func testFetchTodosSuccess() {
        // Given
        Current.todoService = TodoServiceMock(shouldSucceed: true)
        // When
        let actions = effects.fetchTodos.run(with: FetchTodosAction())
        // Then
        XCTAssertEqual(actions.count, 1)
        let action = actions[0] as! DidFetchTodosAction
        XCTAssertEqual(action.todos.count, 4)
    }

    func testFetchTodosFailure() {
        // Given
        Current.todoService = TodoServiceMock(shouldSucceed: false)
        // When
        let actions = effects.fetchTodos.run(with: FetchTodosAction())
        // Then
        XCTAssertEqual(actions.count, 1)
        let action = actions[0] as! DidFailFetchingTodosAction
        XCTAssertEqual(action.error, "Something bad happened, and the todos could not be fetched.")
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
