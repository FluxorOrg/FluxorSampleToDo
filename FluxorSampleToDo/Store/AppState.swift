/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

struct AppState: Encodable {
    var todos = TodosState()
}

struct TodosState: Encodable {
    var todos = [Todo]()
    var loadingTodos = false
    var error: String?
}
