/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

class TodoListViewModel: ViewModel {
    func fetchTodos() {
        store.dispatch(action: FetchTodosAction())
    }

    func toggle(todo: Todo) {
        if todo.done {
            store.dispatch(action: UncompleteTodoAction(todo: todo))
        } else {
            store.dispatch(action: CompleteTodoAction(todo: todo))
        }
    }

    func delete(at index: Int) {
        store.dispatch(action: DeleteTodoAction(index: index))
    }
}
