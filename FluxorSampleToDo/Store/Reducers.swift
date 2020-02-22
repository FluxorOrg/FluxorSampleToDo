/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Fluxor

struct Reducers {
    static let fetchingTodosReducer = createReducer { (state: AppState, action) in
        var state = state
        switch action {
        case is FetchTodosAction:
            state.todos.loadingTodos = true
            state.todos.error = nil
        case let didFetchTodosAction as DidFetchTodosAction:
            state.todos.todos = didFetchTodosAction.todos
            state.todos.loadingTodos = false
        case let didFailFetchingTodosAction as DidFailFetchingTodosAction:
            state.todos.todos = []
            state.todos.loadingTodos = false
            state.todos.error = didFailFetchingTodosAction.error
        default:
            ()
        }
        return state
    }

    static let handlingTodosReducer = createReducer { (state: AppState, action) in
        var state = state
        switch action {
        case let addTodoAction as AddTodoAction:
            state.todos.todos.append(Todo(title: addTodoAction.title))
        case let completeTodoAction as CompleteTodoAction:
            state.todos.todos = state.todos.todos.map {
                guard $0 == completeTodoAction.todo else { return $0 }
                var todo = $0
                todo.done = true
                return todo
            }
        case let uncompleteTodoAction as UncompleteTodoAction:
            state.todos.todos = state.todos.todos.map {
                guard $0 == uncompleteTodoAction.todo else { return $0 }
                var todo = $0
                todo.done = false
                return todo
            }
        case let deleteTodoAction as DeleteTodoAction:
            state.todos.todos.remove(at: deleteTodoAction.index)
        default:
            ()
        }
        return state
    }
}
