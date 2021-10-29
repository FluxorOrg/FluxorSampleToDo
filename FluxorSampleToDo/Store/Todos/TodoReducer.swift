/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Fluxor

let todoReducer = Reducer<TodoState>(
    ReduceOn(FetchingActions.fetchTodos) { state, _ in
        state.loadingTodos = true
        state.error = nil
    },
    ReduceOn(FetchingActions.didFetchTodos) { state, action in
        state.todos = action.payload
        state.loadingTodos = false
    },
    ReduceOn(FetchingActions.didFailFetchingTodos) { state, action in
        state.todos = []
        state.loadingTodos = false
        state.error = action.payload
    },
    ReduceOn(HandlingActions.addTodo) { state, action in
        state.todos.append(Todo(title: action.payload))
    },
    ReduceOn(HandlingActions.completeTodo) { state, action in
        state.todos = state.todos.map {
            guard $0 == action.payload else { return $0 }
            var todo = $0
            todo.done = true
            return todo
        }
    },
    ReduceOn(HandlingActions.uncompleteTodo) { state, action in
        state.todos = state.todos.map {
            guard $0 == action.payload else { return $0 }
            var todo = $0
            todo.done = false
            return todo
        }
    },
    ReduceOn(HandlingActions.deleteTodo) { state, action in
        state.todos.remove(at: action.payload)
    }
)
