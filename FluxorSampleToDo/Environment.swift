/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Fluxor
import FluxorExplorerStoreInterceptor
import UIKit

struct Environment {
    var todoService: TodoServiceProtocol = TodoService()
    let store: Store<AppState> = {
        let store = Store(initialState: AppState())
        store.register(reducer: FetchingTodosReducer())
        store.register(reducer: HandlingTodosReducer())
        store.register(effects: TodosEffects.self)
        #if DEBUG
        store.register(interceptor: FluxorExplorerStoreInterceptor(displayName: UIDevice.current.name))
        #endif
        return store
    }()
}

var Current = Environment()
