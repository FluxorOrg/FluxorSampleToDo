/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Fluxor
import SwiftUI

struct AddTodoView {
    var model = AddTodoViewModel()
    @Binding var showAddSheet: Bool
    @State private var todoTitle = ""
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
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView(model: .init(store: previewStore), showAddSheet: .constant(false))
    }
}
