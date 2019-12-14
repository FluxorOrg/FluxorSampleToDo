//
//  TodoService.swift
//  FluxorSampleToDo
//
//  Created by Morten Bjerg Gregersen on 27/11/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

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
        #if DEBUG
        if CommandLine.arguments.contains("-fail-fetching") {
           url = URL(string: "https://google.com")!
        }
        #endif
        return urlSession
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: [Todo].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
