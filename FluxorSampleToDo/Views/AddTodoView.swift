//
//  AddTodoView.swift
//  FluxorSampleToDo
//
//  Created by Morten Bjerg Gregersen on 23/11/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

import Fluxor
import SwiftUI

struct AddTodoView {
    var model = Model()
    @Binding var showAddSheet: Bool
    @State private var todoTitle = ""
}

extension AddTodoView {
    class Model: ViewModel {
        func addTodo(title: String) {
            store.dispatch(action: AddTodoAction(title: title))
        }
    }
}

extension AddTodoView: View {
    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $todoTitle)
                    .disableAutocorrection(true)
            }
            .navigationBarTitle("Add Todo")
            .navigationBarItems(leading: Button("Cancel") {
                self.showAddSheet = false
            }, trailing: Button("Save") {
                self.model.addTodo(title: self.todoTitle)
                self.showAddSheet = false
            })
        }
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView(model: .init(store: previewStore), showAddSheet: .constant(false))
    }
}
