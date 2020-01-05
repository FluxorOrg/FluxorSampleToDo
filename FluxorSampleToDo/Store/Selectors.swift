/**
* FluxorSampleToDo
*  Copyright (c) Morten Bjerg Gregersen 2020
*  MIT license, see LICENSE file for details
*/

import Foundation

struct Selectors {
    static let getTodos: (AppState) -> [Todo] = { $0.todos }
    static let isLoadingTodos: (AppState) -> Bool = { $0.loadingTodos }
    static let getError: (AppState) -> String? = { $0.error }
    static let shouldShowError: (AppState) -> Bool = { $0.error != nil }
}
