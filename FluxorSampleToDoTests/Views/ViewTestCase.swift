//
//  ViewTestCase.swift
//  FluxorSampleToDoSwiftUI-Tests
//
//  Created by Morten Bjerg Gregersen on 29/10/2021.
//  Copyright © 2021 MoGee. All rights reserved.
//

@testable import FluxorSampleToDoSwiftUI
import FluxorTestSupport
import XCTest

class ViewTestCase: XCTestCase {
    var mockStore: MockStore<AppState, AppEnvironment>!

    override func setUp() {
        super.setUp()
        mockStore = MockStore(initialState: AppState(), environment: AppEnvironment())
        TodoApp.store = mockStore
    }
}
