/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Fluxor

struct FetchingTodosReducer: Reducer {
    typealias State = AppState

    func reduce(state: AppState, action: Action) -> AppState {
        var state = state
        switch action {
        case is FetchTodosAction:
            state.loadingTodos = true
            state.error = nil
        case let didFetchTodosAction as DidFetchTodosAction:
            state.todos = didFetchTodosAction.todos
            state.loadingTodos = false
        case let didFailFetchingTodosAction as DidFailFetchingTodosAction:
            state.todos = []
            state.loadingTodos = false
            state.error = didFailFetchingTodosAction.error
        default:
            ()
        }
        return state
    }
}

struct HandlingTodosReducer: Reducer {
    typealias State = AppState

    func reduce(state: AppState, action: Action) -> AppState {
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
            state.todos.remove(at: deleteTodoAction.index)
        default:
            ()
        }
        return state
    }
}
