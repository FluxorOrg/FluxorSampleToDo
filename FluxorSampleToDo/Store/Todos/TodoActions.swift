/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Fluxor

enum FetchingActions {
    static let fetchTodos = ActionTemplate(id: "[Fetching] Fetch todos")
    static let didFetchTodos = ActionTemplate(id: "[Fetching] Did fetch todos", payloadType: [Todo].self)
    static let didFailFetchingTodos = ActionTemplate(id: "[Fetching] Did fail fetching todos", payloadType: String.self)
    static let dismissError = ActionTemplate(id: "[Fetching] Dismiss error")
}

enum HandlingActions {
    static let addTodo = ActionTemplate(id: "[Handling] Add todo", payloadType: String.self)
    static let completeTodo = ActionTemplate(id: "[Handling] Complete todo", payloadType: Todo.self)
    static let uncompleteTodo = ActionTemplate(id: "[Handling] Uncomplete todo", payloadType: Todo.self)
    static let deleteTodo = ActionTemplate(id: "[Handling] Delete todo", payloadType: Int.self)
}
