/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

class AddTodoViewModel: ViewModel {
    func addTodo(title: String) {
        store.dispatch(action: AddTodoAction(title: title))
    }
}
