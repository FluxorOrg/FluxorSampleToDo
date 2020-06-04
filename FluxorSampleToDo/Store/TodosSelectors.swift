/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Fluxor

struct TodosSelectors {
    private static let getTodosState = Selector(keyPath: \AppState.todos)
    static let getTodos = Selector.with(TodosSelectors.getTodosState) { $0.todos }
    static let isLoadingTodos = Selector.with(TodosSelectors.getTodosState) { $0.loadingTodos }
    static let getError = Selector.with(TodosSelectors.getTodosState) { $0.error }
    static let shouldShowError = Selector.with(TodosSelectors.getTodosState) { $0.error != nil }
}
