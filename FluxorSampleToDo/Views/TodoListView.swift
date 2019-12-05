//
//  TodoListView.swift
//  FluxorSampleToDo
//
//  Created by Morten Bjerg Gregersen on 19/11/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

import Combine
import Fluxor
import FluxorSwiftUI
import SwiftUI

struct TodoListView: View {
    var viewModel: TodoListViewModel
    @State private var todos = [Todo]()
    @State private var loading = false
    @State private var error: String?

    @State private var showAddSheet = false
    @State private var showErrorAlert = false

    var body: some View {
        NavigationView {
            List {
                if self.loading {
                    HStack {
                        ActivityIndicator()
                        Text("Loading todos...")
                    }
                } else if todos.count > 0 {
                    ForEach(todos, id: \.id) { todo in
                        TodoRowView(todo: todo) { self.viewModel.toggle(todo: todo) }
                    }
                    .onDelete(perform: self.viewModel.delete)
                } else {
                    Text("No todos").multilineTextAlignment(.center)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle("Fluxor todos")
            .navigationBarItems(trailing: Button("Add") { self.showAddSheet = true })
            .sheet(isPresented: $showAddSheet) {
                AddTodoView(viewModel: .init(store: store), showAddSheet: self.$showAddSheet)
            }
            .alert(isPresented: $showErrorAlert) {
                Alert(title: Text("Error"), message: Text(error ?? ""), dismissButton: Alert.Button.default(Text("OK")))
            }
        }
        .onAppear {
            self.viewModel.fetchTodos()
        }
        .onReceive(viewModel.todos, perform: { self.todos = $0 })
        .onReceive(viewModel.loading, perform: { self.loading = $0 })
        .onReceive(viewModel.error, perform: { self.error = $0; self.showErrorAlert = $0 != nil })
    }
}

class TodoListViewModel: ViewModel<AppState> {
    var todos: AnyPublisher<[Todo], Never>
    var loading: AnyPublisher<Bool, Never>
    var error: AnyPublisher<String?, Never>

    override init(store: Store<AppState>) {
        self.todos = store.select(\.todos)
        self.loading = store.select(\.loadingTodos)
        self.error = store.select(\.error)
        super.init(store: store)
    }

    func fetchTodos() {
        self.store.dispatch(action: FetchTodosAction())
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

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView(viewModel: .init(store: store))
    }
}
