//
//  RootView.swift
//  FluxorSampleToDo
//
//  Created by Morten Bjerg Gregersen on 12/12/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

import SwiftUI

struct RootView: View {
    @State private var showAddSheet = false

    var body: some View {
        NavigationView {
            TodoListView()
                .navigationBarItems(trailing: Button("Add") {
                    self.showAddSheet = true
                })
        }.sheet(isPresented: $showAddSheet) {
            AddTodoView(model: .init(), showAddSheet: self.$showAddSheet)
        }
    }
}
