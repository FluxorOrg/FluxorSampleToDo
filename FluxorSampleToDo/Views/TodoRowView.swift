//
//  TodoRowView.swift
//  FluxorSampleToDo
//
//  Created by Morten Bjerg Gregersen on 24/11/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

import SwiftUI

struct TodoRowView: View {
    var todo: Todo
    
    var body: some View {
        HStack {
            Text(todo.title)
            Spacer()
            Image(systemName: todo.done ? "checkmark.circle.fill" : "circle")
        }
    }
}
