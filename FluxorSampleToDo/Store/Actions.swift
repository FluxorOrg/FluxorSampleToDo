//
//  Actions.swift
//  FluxorSampleToDo
//
//  Created by Morten Bjerg Gregersen on 23/11/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

import Fluxor
import Foundation

struct FetchTodosAction: Action {}

struct DidFetchTodosAction: Action {
    let todos: [Todo]
}

struct DidFailFetchingTodosAction: Action {
    let error: String
}

struct ClearFetchingErrorAction: Action {}

struct AddTodoAction: Action {
    let title: String
}

struct CompleteTodoAction: Action {
    let todo: Todo
}

struct UncompleteTodoAction: Action {
    let todo: Todo
}

struct DeleteTodoAction: Action {
    let offsets: IndexSet
}
