/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Combine
import Fluxor
import SwiftUI

struct TodoListView: View {
    @ObservedObject var store: Store<AppState, AppEnvironment>
    @StoreValue(TodosSelectors.getTodos) var todos
    @StoreValue(TodosSelectors.isLoadingTodos) var loading
    @StoreValue(TodosSelectors.getError) var error

    var body: some View {
        List {
            if loading {
                HStack {
                    ActivityIndicator()
                    Text("Loading todos...")
                }
            } else if todos.count > 0 {
                ForEach(todos, id: \.id) { todo in
                    TodoRowView(todo: todo) {
                        if todo.done {
                            store.dispatch(action: HandlingActions.uncompleteTodo(payload: todo))
                        } else {
                            store.dispatch(action: HandlingActions.completeTodo(payload: todo))
                        }
                    }
                }
                .onDelete {
                    store.dispatch(action: HandlingActions.deleteTodo(payload: $0.first!))
                }
            } else {
                Text("No todos").multilineTextAlignment(.center)
            }
        }
        .navigationTitle("Fluxor Todos")
        .onAppear {
            store.dispatch(action: FetchingActions.fetchTodos())
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(store: previewStore)
    }
}
