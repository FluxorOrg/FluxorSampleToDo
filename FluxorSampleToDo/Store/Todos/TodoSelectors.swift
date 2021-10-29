/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Fluxor

struct TodosSelectors {
    private static let getTodoState = Selector(keyPath: \AppState.todo)
    static let getTodos = Selector.with(TodosSelectors.getTodoState) { $0.todos }
    static let isLoadingTodos = Selector.with(TodosSelectors.getTodoState) { $0.loadingTodos }
    static let getError = Selector.with(TodosSelectors.getTodoState) { $0.error }
}
