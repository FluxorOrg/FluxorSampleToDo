/**
 * FluxorSampleToDoTests
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Fluxor
#if SWIFTUI
@testable import FluxorSampleToDoSwiftUI
#else
@testable import FluxorSampleToDoUIKit
#endif
import XCTest

class NavigationReducerTests: XCTestCase {
    let reducer = navigationReducer

    func testShowAddSheet() {
        var state = NavigationState()
        reducer.reduce(&state, NavigationActions.showAddSheet())
        XCTAssertTrue(state.showAddSheet)
    }

    func testHideAddSheet() {
        var state = NavigationState()
        reducer.reduce(&state, NavigationActions.hideAddSheet())
        XCTAssertFalse(state.showAddSheet)
    }

    func testIrrelevantAction() {
        var state = NavigationState()
        reducer.reduce(&state, IrrelevantAction())
        XCTAssertEqual(state, state)
    }
}

private struct IrrelevantAction: Action {}

extension NavigationState: Equatable {
    public static func == (lhs: NavigationState, rhs: NavigationState) -> Bool {
        return lhs.showAddSheet == rhs.showAddSheet
    }
}
