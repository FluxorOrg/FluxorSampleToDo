/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Combine
import Fluxor
import SwiftUI

struct TodoListView {
    var model = TodoListViewModel()
    @State var todos = [Todo]()
    @State var loading = false
    @State var error: String?
    @State var showErrorAlert = false
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
                .onDelete(perform: { self.model.delete(at: $0.first!) })
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
        .onReceive(model.store.select(TodosSelectors.getTodos), perform: { self.todos = $0 })
        .onReceive(model.store.select(TodosSelectors.isLoadingTodos), perform: { self.loading = $0 })
        .onReceive(model.store.select(TodosSelectors.getError), perform: { self.error = $0 })
        .onReceive(model.store.select(TodosSelectors.shouldShowError), perform: { self.showErrorAlert = $0 })
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(model: .init(store: previewStore))
    }
}
