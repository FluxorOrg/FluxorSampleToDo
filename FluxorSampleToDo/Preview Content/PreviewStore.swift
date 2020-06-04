//
//  PreviewStore.swift
//  FluxorSampleToDo
//
//  Created by Morten Bjerg Gregersen on 08/12/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

import Fluxor

let previewStore: Store<AppState, AppEnvironment> = {
    let state = AppState(todos: TodosState(todos: [Todo(title: "Dispatch actions"),
                                                   Todo(title: "Create effects"),
                                                   Todo(title: "Select something"),
                                                   Todo(title: "Intercept everything")]))
    return Store(initialState: state, environment: AppEnvironment())
}()
