//
//  Environment.swift
//  FluxorSampleToDo
//
//  Created by Morten Bjerg Gregersen on 09/12/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

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
