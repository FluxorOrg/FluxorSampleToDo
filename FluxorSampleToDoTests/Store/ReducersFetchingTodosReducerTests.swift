//
//  ReducersTests.swift
//  FluxorSampleToDoTests
//
//  Created by Morten Bjerg Gregersen on 28/11/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

@testable import Fluxor
@testable import FluxorSampleToDo
import XCTest

class ReducersFetchingTodosReducerTests: XCTestCase {
    let reducer = Reducers.fetchingTodosReducer
    
    func testFetchTodosAction() {
        let newState = reducer.reduce(AppState(), FetchTodosAction())
        XCTAssertTrue(newState.loadingTodos)
        XCTAssertNil(newState.error)
    }

    func testDidFetchTodosAction() {
        let todos = [Todo(title: "Buy milk"), Todo(title: "Walk the dog")]
        let newState = reducer.reduce(AppState(), DidFetchTodosAction(todos: todos))
        XCTAssertEqual(newState.todos, todos)
        XCTAssertFalse(newState.loadingTodos)
    }

    func testDidFailFetchingTodosAction() {
        let todos = [Todo(title: "Buy milk"), Todo(title: "Walk the dog")]
        let error = "Some error occurred"
        let newState = reducer.reduce(AppState(todos: todos), DidFailFetchingTodosAction(error: error))
        XCTAssertEqual(newState.todos, [])
        XCTAssertFalse(newState.loadingTodos)
        XCTAssertEqual(newState.error, error)
    }

    func testIrrelevantAction() {
        let state = AppState()
        let newState = reducer.reduce(state, IrrelevantAction())
        XCTAssertEqual(newState, state)
    }
}

fileprivate struct IrrelevantAction: Action {}
extension AppState: Equatable {
    public static func == (lhs: AppState, rhs: AppState) -> Bool {
        return lhs.todos == rhs.todos
            && lhs.loadingTodos == rhs.loadingTodos
            && lhs.error == rhs.error
    }
}
