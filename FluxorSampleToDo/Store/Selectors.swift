//
//  Selectors.swift
//  FluxorSampleToDo
//
//  Created by Morten Bjerg Gregersen on 24/11/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

import Foundation

struct Selectors {
    static let getTodos: (AppState) -> [Todo] = { $0.todos }
    static let isLoadingTodos: (AppState) -> Bool = { $0.loadingTodos }
    static let getError: (AppState) -> String? = { $0.error }
    static let shouldShowError: (AppState) -> Bool = { $0.error != nil }
}
