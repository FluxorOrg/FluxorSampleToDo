/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Fluxor
import FluxorExplorerInterceptor
import UIKit

struct Environment {
    var todoService: TodoServiceProtocol = TodoService()
    let store: Store<AppState> = {
        let store = Store(initialState: AppState())
        store.register(reducer: Reducers.fetchingTodosReducer)
        store.register(reducer: Reducers.handlingTodosReducer)
        store.register(effects: TodosEffects())
        #if DEBUG
        store.register(interceptor: FluxorExplorerInterceptor(displayName: UIDevice.current.name))
        #endif
        return store
    }()
}

var Current = Environment()
