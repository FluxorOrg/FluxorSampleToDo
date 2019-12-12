//
//  Environment.swift
//  FluxorSampleToDo
//
//  Created by Morten Bjerg Gregersen on 09/12/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

import Fluxor

struct Environment {
    var todoService: TodoServiceProtocol = TodoService()
    let store: Store<AppState> = {
        let store = Store(initialState: AppState())
        store.register(reducer: Reducers.fetchingTodosReducer)
        store.register(reducer: Reducers.handlingTodosReducer)
        store.register(effects: TodosEffects.self)
        return store
    }()
}

var Current = Environment()
