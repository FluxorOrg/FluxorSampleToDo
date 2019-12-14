//
//  TodoListView.swift
//  FluxorSampleToDo
//
//  Created by Morten Bjerg Gregersen on 19/11/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

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
            Alert(title: Text("Error"), message: Text(error ?? ""), dismissButton: Alert.Button.default(Text("OK")))
        }
        .onAppear {
            self.model.fetchTodos()
        }
        .onReceive(model.store.select(\.todos), perform: { self.todos = $0 })
        .onReceive(model.store.select(\.loadingTodos), perform: { self.loading = $0 })
        .onReceive(model.store.select(\.error), perform: { self.error = $0; self.showErrorAlert = $0 != nil })
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(model: .init(store: previewStore))
    }
}
