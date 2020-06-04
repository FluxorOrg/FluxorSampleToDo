/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Fluxor

class ViewModel {
    let store: Store<AppState, Void>

    init(store: Store<AppState, Void> = Current.store) {
        self.store = store
    }
}
