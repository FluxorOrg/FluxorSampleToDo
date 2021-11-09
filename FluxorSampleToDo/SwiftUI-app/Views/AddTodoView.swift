/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Fluxor
import SwiftUI

struct AddTodoView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var store: Store<AppState, AppEnvironment>
    @State private var todoTitle = ""

    var body: some View {
        NavigationView {
            Form {
                TextField("Title", text: $todoTitle)
                    .disableAutocorrection(true)
            }
            .navigationTitle("Add Todo")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        store.dispatch(action: HandlingActions.addTodo(payload: self.todoTitle))
                        dismiss()
                    }
                }
            }
        }
        .navigationViewStyle(.stack)
        .onAppear { self.didAppear?(self) }
    }

    internal var didAppear: ((Self) -> Void)?
}

#if !TESTING
struct AddTodoView_Previews: PreviewProvider {
    static var previews: some View {
        AddTodoView(store: previewStore)
    }
}
#endif
