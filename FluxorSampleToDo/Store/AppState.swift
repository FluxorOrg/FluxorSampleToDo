//
//  AppState.swift
//  FluxorSampleToDo
//
//  Created by Morten Bjerg Gregersen on 21/11/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

import Foundation

struct AppState: Encodable {
    var todos: [Todo] = [
        Todo(title: "Dispatch actions"),
        Todo(title: "Create effects"),
        Todo(title: "Select something"),
        Todo(title: "Intercept everything"),
    ]
}
