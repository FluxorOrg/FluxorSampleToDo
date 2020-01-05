/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

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
