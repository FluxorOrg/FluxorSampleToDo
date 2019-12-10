//
//  AppState.swift
//  FluxorSampleToDo
//
//  Created by Morten Bjerg Gregersen on 21/11/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

struct AppState: Encodable {
    var todos = [Todo]()
    var loadingTodos = false
    var error: String?
}
