/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Fluxor
import FluxorExplorerInterceptor
import UIKit

struct AppEnvironment {
    var todoService: TodoServiceProtocol = TodoService()
}

struct Current {
    static let store: Store<AppState, AppEnvironment> = {
        let store = Store(initialState: AppState(), environment: AppEnvironment())
        store.register(reducer: Reducers.fetchingTodosReducer)
        store.register(reducer: Reducers.handlingTodosReducer)
        store.register(effects: TodosEffects())
        #if DEBUG
        store.register(interceptor: FluxorExplorerInterceptor(displayName: UIDevice.current.name))
        #endif
        return store
    }()
}
