/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Combine
import Fluxor
import Foundation

class TodosEffects: Effects {
    let fetchTodos = createEffectCreator { (actions: AnyPublisher<Action, Never>) in
        actions
            .ofType(FetchTodosAction.self)
            .flatMap { _ in
                Current.todoService.fetchTodos()
                    .map { DidFetchTodosAction(todos: $0) }
                    .catch { _ in Just(DidFailFetchingTodosAction(error: "Something bad happened, and the todos could not be fetched.")) }
            }
            .eraseToAnyPublisher()
    }
}
