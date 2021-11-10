/*
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Fluxor

enum NavigationSelectors {
    private static let getNavigationState = Selector(keyPath: \AppState.navigation)
    static let shoulShowAddShet = Selector.with(getNavigationState) { $0.showAddSheet }
}
