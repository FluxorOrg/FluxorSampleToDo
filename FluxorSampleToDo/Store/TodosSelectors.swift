/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Fluxor

struct TodosSelectors {
    private static let getTodosState = createRootSelector(keyPath: \AppState.todos)
    static let getTodos = createSelector(TodosSelectors.getTodosState) { $0.todos }
    static let isLoadingTodos = createSelector(TodosSelectors.getTodosState) { $0.loadingTodos }
    static let getError = createSelector(TodosSelectors.getTodosState) { $0.error }
    static let shouldShowError = createSelector(TodosSelectors.getTodosState) { $0.error != nil }
}
