/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Fluxor

struct Reducers {
    static let fetchingTodosReducer = Reducer<AppState>(
        ReduceOn(FetchTodosAction.self) { state, _ in
            state.todos.loadingTodos = true
            state.todos.error = nil
        },
        ReduceOn(DidFetchTodosAction.self) { state, action in
            state.todos.todos = action.todos
            state.todos.loadingTodos = false
        },
        ReduceOn(DidFailFetchingTodosAction.self) { state, action in
            state.todos.todos = []
            state.todos.loadingTodos = false
            state.todos.error = action.error
        }
    )

    static let handlingTodosReducer = Reducer<AppState>(
        ReduceOn(AddTodoAction.self) { state, action in
            state.todos.todos.append(Todo(title: action.title))
        },
        ReduceOn(CompleteTodoAction.self) { state, action in
            state.todos.todos = state.todos.todos.map {
                guard $0 == action.todo else { return $0 }
                var todo = $0
                todo.done = true
                return todo
            }
        },
        ReduceOn(UncompleteTodoAction.self) { state, action in
            state.todos.todos = state.todos.todos.map {
                guard $0 == action.todo else { return $0 }
                var todo = $0
                todo.done = false
                return todo
            }
        },
        ReduceOn(DeleteTodoAction.self) { state, action in
            state.todos.todos.remove(at: action.index)
        }
    )
}
