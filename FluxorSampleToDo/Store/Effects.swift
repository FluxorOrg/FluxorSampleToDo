/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Combine
import Fluxor
import Foundation

class TodosEffects: Effects {
    typealias Environment = AppEnvironment

    let fetchTodos = Effect<Environment>.dispatchingOne { actions, environment in
        actions
            .ofType(FetchTodosAction.self)
            .flatMap { _ in
                environment.todoService.fetchTodos()
                    .map { DidFetchTodosAction(todos: $0) }
                    .catch { _ -> Just<Action> in
                        Just(DidFailFetchingTodosAction(
                            error: "Something bad happened, and the todos could not be fetched."
                        ))
                    }
            }
            .eraseToAnyPublisher()
    }
}
