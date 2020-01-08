/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import SwiftUI

struct TodoRowView: View {
    var todo: Todo
    var didSelect: () -> Void

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

struct TodoRowView_Previews: PreviewProvider {
    static var previews: some View {
        TodoRowView(todo: Todo(title: "Buy milk"), didSelect: {})
    }
}
