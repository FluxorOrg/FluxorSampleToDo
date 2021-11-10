/*
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

// swiftlint:disable force_cast

class TodosEffectsTests: XCTestCase {
    private let effects = TodosEffects()
    private var environment: AppEnvironment!

    override func setUp() {
        environment = AppEnvironment()
    }

    func testFetchTodosSuccess() throws {
        // Given
        environment.todoService = TodoServiceMock(shouldSucceed: true)
        // When
        let actions = try EffectRunner.run(effects.fetchTodos,
                                           with: FetchingActions.fetchTodos(),
                                           environment: environment)!
        // Then
        XCTAssertEqual(actions.count, 1)
        let action = actions[0] as! AnonymousAction<[Todo]>
        XCTAssertEqual(action.payload.count, 4)
    }

    func testFetchTodosFailure() throws {
        // Given
        environment.todoService = TodoServiceMock(shouldSucceed: false)
        // When
        let actions = try EffectRunner.run(effects.fetchTodos,
                                           with: FetchingActions.fetchTodos(),
                                           environment: environment)!
        // Then
        XCTAssertEqual(actions.count, 1)
        let action = actions[0] as! AnonymousAction<String>
        XCTAssertEqual(action.payload, "Something bad happened, and the todos could not be fetched.")
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
