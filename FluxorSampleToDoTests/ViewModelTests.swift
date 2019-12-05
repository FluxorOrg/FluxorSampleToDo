//
//  ViewModelTests.swift
//  FluxorSampleToDoTests
//
//  Created by Morten Bjerg Gregersen on 25/11/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

import Fluxor
@testable import FluxorSampleToDo
import XCTest

class ViewModelTests: XCTestCase {
    fileprivate var store: Store<TestState>!

    override func setUp() {
        super.setUp()
        store = Store(initialState: TestState())
        store.register(reducer: Reducer<TestState>(reduce: { state, action in
            var state = state
            if let action = action as? UpdateValueAction {
                state.someValue = action.newValue
            }
            return state
        }))
    }

    func testSetupSelectors() {
        let viewModel = TestViewModel(store: store)
        XCTAssertTrue(viewModel.setupSelectorsCalled)
    }

    func testBind() {
        // Given
        let newValue = 42
        let expectation = XCTestExpectation(description: debugDescription)
        let viewModel = TestViewModel(store: store)
        viewModel.didSetValue = {
            expectation.fulfill()
        }
        try! viewModel.bind(selector: { $0.someValue }, to: \TestViewModel.value)
        // When
        store.dispatch(action: UpdateValueAction(newValue: newValue))
        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(viewModel.value, newValue)
    }

    func testBindFailing() {
        let viewModel = OtherTestViewModel(store: store)
        XCTAssertThrowsError(try viewModel.bind(selector: { $0.someValue }, to: \TestViewModel.value))
    }
}

fileprivate class TestViewModel: ViewModel<TestState> {
    var setupSelectorsCalled = false
    var value: Int? { didSet {
        didSetValue?()
    } }
    var didSetValue: (() -> Void)?

    override func setupSelectors() {
        super.setupSelectors()
        setupSelectorsCalled = true
    }
}

fileprivate class OtherTestViewModel: ViewModel<TestState> {}

fileprivate struct TestState: Encodable {
    var someValue = 0
}

fileprivate struct UpdateValueAction: Action {
    let newValue: Int
}
