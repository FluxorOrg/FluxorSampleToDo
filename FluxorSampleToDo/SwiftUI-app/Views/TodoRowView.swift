/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import SwiftUI

struct TodoRowView: View {
    let todo: Todo
    let didSelect: () -> Void

    var body: some View {
        Button(action: didSelect) {
            HStack {
                Text(todo.title)
                Spacer()
                Image(systemName: todo.done ? "checkmark.circle.fill" : "circle")
            }
        }
        .accessibility(label: Text("\(todo.title) - \(todo.done ? "Done" : "Undone")"))
    }
}

#if !TESTING
struct TodoRowView_Previews: PreviewProvider {
    static var previews: some View {
        TodoRowView(todo: Todo(title: "Buy milk"), didSelect: {})
    }
}
#endif
