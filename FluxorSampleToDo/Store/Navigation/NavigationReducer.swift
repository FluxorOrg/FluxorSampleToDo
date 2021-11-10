/*
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2021
 *  MIT license, see LICENSE file for details
 */

import Fluxor

let navigationReducer = Reducer<NavigationState>(
    ReduceOn(NavigationActions.showAddSheet) { state, _ in
        state.showAddSheet = true
    },
    ReduceOn(NavigationActions.hideAddSheet) { state, _ in
        state.showAddSheet = false
    }
)
