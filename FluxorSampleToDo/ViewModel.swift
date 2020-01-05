/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Fluxor

class ViewModel {
    let store: Store<AppState>

    init(store: Store<AppState> = Current.store) {
        self.store = store
    }
}
