//
//  AddTodoView.swift
//  FluxorSampleToDo
//
//  Created by Morten Bjerg Gregersen on 23/11/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

import SwiftUI

struct AddTodoView {
    @ObservedObject var viewModel: AddTodoViewModel
    @Binding var showAddSheet: Bool
    @State var todoTitle = ""
}

extension AddTodoView: View {
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $todoTitle)
            }
            .navigationBarTitle("Add Todo")
            .navigationBarItems(leading: Button("Cancel") {
                self.showAddSheet = false
            }, trailing: Button("Save") {
                self.viewModel.addTodo(title: self.todoTitle)
                self.showAddSheet = false
            })
        }
    }
}

class AddTodoViewModel: ViewModel<AppState> {
    func addTodo(title: String) {
        store.dispatch(action: AddTodoAction(title: title))
    }
}
