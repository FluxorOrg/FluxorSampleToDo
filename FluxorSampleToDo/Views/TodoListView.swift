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

struct TodoListView: View {
    @ObservedObject var viewModel: TodoListViewModel
    @State private var showAddSheet = false

    var body: some View {
        NavigationView {
            List {
                if viewModel.todos.count > 0 {
                    ForEach(viewModel.todos, id: \.id) { todo in
                        Button(action: {
                            self.viewModel.toggle(todo: todo)
                        }, label: {
                            HStack {
                                Text(todo.title)
                                Spacer()
                                Image(systemName: todo.done ? "checkmark.circle.fill" : "circle")
                            }
                        })
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
        }
    }
}

class TodoListViewModel: ViewModel, ObservableObject {
    var todos = [Todo]()

    override func setupSelectors() {
        assign(selector: Selectors.getTodos, to: \TodoListViewModel.todos)
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
