/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Combine
import Foundation

protocol TodoServiceProtocol {
    func fetchTodos() -> AnyPublisher<[Todo], Error>
}

class TodoService: TodoServiceProtocol {
    let urlSession: URLSession

    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }

    func fetchTodos() -> AnyPublisher<[Todo], Error> {
        var url = URL(string: "https://raw.githubusercontent.com/MortenGregersen/FluxorSampleToDo/master/todos.json")!
        #if !SWIFTUI
        // Only used in the UI tests for the UIKit app
        if CommandLine.arguments.contains("-fail-fetching") {
            url = URL(string: "https://httpstat.us/500")!
        }
        #endif
        return urlSession
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Todo].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
