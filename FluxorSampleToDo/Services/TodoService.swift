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
        return urlSession
            .dataTaskPublisher(for: URL(string: "https://google.com/me")!)
            .map { _ in """
            [
                {
                    "title": "Dispatch actions",
                    "done": false
                },
                {
                    "title": "Create effects",
                    "done": false
                },
                {
                    "title": "Select something",
                    "done": false
                },
                {
                    "title": "Intercept everything",
                    "done": false
                }
            ]
            """.data(using: .utf8)!
            } // { $0.data }
            .decode(type: [Todo].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
