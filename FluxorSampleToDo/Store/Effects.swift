/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Combine
import Fluxor
import Foundation

class TodosEffects: Effects {
    typealias Environment = Void

    let fetchTodos = Effect<Environment>.dispatchingOne { actions, _ in
        actions
            .ofType(FetchTodosAction.self)
            .flatMap { _ -> AnyPublisher<Action, Never> in
                Current.todoService.fetchTodos()
                    .map { DidFetchTodosAction(todos: $0) }
                    .catch { _ in Just(DidFailFetchingTodosAction(error: "Something bad happened, and the todos could not be fetched.")) }
                .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
