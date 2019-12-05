//
//  Effects.swift
//  FluxorSampleToDo
//
//  Created by Morten Bjerg Gregersen on 24/11/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

import Combine
import Fluxor
import Foundation

class TodosEffects: Effects {
    lazy var effects: [Effect] = [fetchTodos]
    private let actions: ActionPublisher
    private let todoService: TodoServiceProtocol

    required convenience init(_ actions: ActionPublisher) {
        self.init(actions, todoService: TodoService())
    }

    init(_ actions: ActionPublisher, todoService: TodoServiceProtocol) {
        self.actions = actions
        self.todoService = todoService
    }

    lazy var fetchTodos: Effect = {
        actions
            .ofType(FetchTodosAction.self)
            .flatMap { _ in
                self.todoService.fetchTodos()
                    .map { DidFetchTodosAction(todos: $0) }
                    .catch { _ in Just(DidFailFetchingTodosAction(error: "Something bad happened, and the todos could not be fetched.")) }
            }
            .eraseToAnyPublisher()

    }()
}
