//
//  SelectorsTests.swift
//  FluxorSampleToDoTests
//
//  Created by Morten Bjerg Gregersen on 25/11/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

@testable import FluxorSampleToDo
import XCTest

class SelectorsTests: XCTestCase {
    let state = AppState(todos: [Todo(title: "Dispatch actions"),
                                 Todo(title: "Create effects"),
                                 Todo(title: "Select something"),
                                 Todo(title: "Intercept everything")],
                         loadingTodos: true,
                         error: "Some error")

    func testGetTodos() {
        XCTAssertEqual(Selectors.getTodos(state), state.todos)
    }

    func testIsLoadingTotods() {
        XCTAssertEqual(Selectors.isLoadingTodos(state), state.loadingTodos)
    }
    
    func testGetError() {
        XCTAssertEqual(Selectors.getError(state), state.error)
    }
    
    func testShouldShowError() {
        XCTAssertEqual(Selectors.shouldShowError(state), true)
    }
}
