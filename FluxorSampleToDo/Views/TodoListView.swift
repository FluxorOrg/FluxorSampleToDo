/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Combine
import Fluxor
import SwiftUI

struct TodoListView {
    var model = Model()
    @State var todos = [Todo]()
    @State var loading = false
    @State var error: String?
    @State var showErrorAlert = false
}

extension TodoListView {
    class Model: ViewModel {
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

        func delete(at offsets: IndexSet) {
            store.dispatch(action: DeleteTodoAction(offsets: offsets))
        }
    }
}

extension TodoListView: View {
    var body: some View {
        List {
            if loading {
                HStack {
                    ActivityIndicator()
                    Text("Loading todos...")
                }
            } else if todos.count > 0 {
                ForEach(todos, id: \.id) { todo in
                    TodoRowView(todo: todo) { self.model.toggle(todo: todo) }
                }
                .onDelete(perform: self.model.delete)
            } else {
                Text("No todos").multilineTextAlignment(.center)
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Fluxor todos")
        .alert(isPresented: $showErrorAlert) {
            Alert(title: Text("Error"), message: Text(error!), dismissButton: .default(Text("OK")))
        }
        .onAppear {
            self.model.fetchTodos()
        }
        .onReceive(model.store.select(Selectors.getTodos), perform: { self.todos = $0 })
        .onReceive(model.store.select(Selectors.isLoadingTodos), perform: { self.loading = $0 })
        .onReceive(model.store.select(Selectors.getError), perform: { self.error = $0 })
        .onReceive(model.store.select(Selectors.shouldShowError), perform: { self.showErrorAlert = $0 })
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(model: .init(store: previewStore))
    }
}
