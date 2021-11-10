/*
 * FluxorSampleToDoTests
 *  Copyright (c) Morten Bjerg Gregersen 2021
 *  MIT license, see LICENSE file for details
 */

import Fluxor
@testable import FluxorSampleToDoSwiftUI
import FluxorTestSupport
import ViewInspector
import XCTest

// swiftlint:disable force_cast

final class RootViewTests: ViewTestCase {
    func testShowAddSheet() throws {
        // Given
        let view = RootView(store: mockStore)
        XCTAssertTrue(mockStore.stateChanges.isEmpty)
        // When
        try view.inspect().navigationView().view(TodoListView.self, 0).toolbar().find(button: "Add").tap()
        // Then
        XCTAssertEqual(mockStore.dispatchedActions[0] as! AnonymousAction<Void>, NavigationActions.showAddSheet())
    }

    func testSheetIsHidden() throws {
        // Given
        mockStore.overrideSelector(NavigationSelectors.shoulShowAddShet, value: false)
        let view = RootView(store: mockStore)
        // Then
        XCTAssertThrowsError(try view.inspect().navigationView().sheet(0).dismiss())
    }

    func testSheetIsShown() throws {
        // Given
        mockStore.overrideSelector(NavigationSelectors.shoulShowAddShet, value: true)
        let view = RootView(store: mockStore)
        // Then
        XCTAssertNoThrow(try view.inspect().navigationView().sheet(0).view(AddTodoView.self))
    }
}

extension RootView: Inspectable {}
extension InspectableSheet: Inspectable {}
extension InspectableSheet: PopupPresenter {}
