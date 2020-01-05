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

    required init(_ actions: ActionPublisher) {
        self.actions = actions
    }

    lazy var fetchTodos = createEffect(
        actions
            .ofType(FetchTodosAction.self)
            .flatMap { _ in
                Current.todoService.fetchTodos()
                    .map { DidFetchTodosAction(todos: $0) }
                    .catch { _ in Just(DidFailFetchingTodosAction(error: "Something bad happened, and the todos could not be fetched.")) }
            }
            .eraseToAnyPublisher()
    )
}
