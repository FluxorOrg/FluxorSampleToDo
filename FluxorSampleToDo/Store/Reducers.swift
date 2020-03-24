/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Fluxor

struct Reducers {
    static let fetchingTodosReducer = createReducer(
        reduceOn(FetchTodosAction.self) { (state: inout AppState, _) in
            state.todos.loadingTodos = true
            state.todos.error = nil
        },
        reduceOn(DidFetchTodosAction.self) { (state: inout AppState, action) in
            state.todos.todos = action.todos
            state.todos.loadingTodos = false
        },
        reduceOn(DidFailFetchingTodosAction.self) { (state: inout AppState, action) in
            state.todos.todos = []
            state.todos.loadingTodos = false
            state.todos.error = action.error
        }
    )

    static let handlingTodosReducer = createReducer(
        reduceOn(AddTodoAction.self) { (state: inout AppState, action) in
            state.todos.todos.append(Todo(title: action.title))
        },
        reduceOn(CompleteTodoAction.self) { (state: inout AppState, action) in
            state.todos.todos = state.todos.todos.map {
                guard $0 == action.todo else { return $0 }
                var todo = $0
                todo.done = true
                return todo
            }
        },
        reduceOn(UncompleteTodoAction.self) { (state: inout AppState, action) in
            state.todos.todos = state.todos.todos.map {
                guard $0 == action.todo else { return $0 }
                var todo = $0
                todo.done = false
                return todo
            }
        },
        reduceOn(DeleteTodoAction.self) { (state: inout AppState, action) in
            state.todos.todos.remove(at: action.index)
        }
    )
}
