/*
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
            .wasCreated(from: FetchingActions.fetchTodos)
            .flatMap { _ in
                environment.todoService.fetchTodos()
                    .map { FetchingActions.didFetchTodos(payload: $0) }
                    .catch { _ -> Just<Action> in
                        Just(FetchingActions.didFailFetchingTodos(
                            payload: "Something bad happened, and the todos could not be fetched."
                        ))
                    }
            }
            .eraseToAnyPublisher()
    }
}
