//
//  Store.swift
//  FluxorSampleToDo
//
//  Created by Morten Bjerg Gregersen on 21/11/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

import Fluxor
import Foundation

let store: Store<AppState> = {
    let store = Store(initialState: AppState())
    store.register(reducer: Reducer<AppState, Action>(reduce: { (state, action) -> AppState in
        var state = state
        switch action {
        case let addTodoAction as AddTodoAction:
            state.todos.append(Todo(title: addTodoAction.title))
        case let completeTodoAction as CompleteTodoAction:
            state.todos = state.todos.map {
                guard $0 == completeTodoAction.todo else { return $0 }
                var todo = $0
                todo.done = true
                return todo
            }
        case let uncompleteTodoAction as UncompleteTodoAction:
            state.todos = state.todos.map {
                guard $0 == uncompleteTodoAction.todo else { return $0 }
                var todo = $0
                todo.done = false
                return todo
            }
        case let deleteTodoAction as DeleteTodoAction:
            state.todos.remove(atOffsets: deleteTodoAction.offsets)
        default:
            ()
        }
        return state
    }))
    return store
}()
