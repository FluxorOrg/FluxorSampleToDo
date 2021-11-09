/*
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2021
 *  MIT license, see LICENSE file for details
 */

import Fluxor
//import FluxorExplorerInterceptor
import UIKit

func createStore() -> Store<AppState, AppEnvironment> {
    let store = Store(initialState: AppState(), environment: AppEnvironment())
    store.register(reducer: todoReducer, for: \.todo)
    store.register(reducer: navigationReducer, for: \.navigation)
    store.register(effects: TodosEffects())
    #if DEBUG
//    store.register(interceptor: PrintInterceptor())
//    store.register(interceptor: FluxorExplorerInterceptor(displayName: UIDevice.current.name))
    #endif
    return store
}
