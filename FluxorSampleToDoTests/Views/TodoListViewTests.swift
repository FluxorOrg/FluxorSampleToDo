//
//  TodoListViewTests.swift
//  FluxorSampleToDoTests
//
//  Created by Morten Bjerg Gregersen on 12/12/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

@testable import Fluxor
@testable import FluxorSampleToDo
@testable import ViewInspector
import XCTest

class TodoListViewTests: XCTestCase {
    let todos = [Todo(title: "Dispatch actions"),
                 Todo(title: "Create effects"),
                 Todo(title: "Select something"),
                 Todo(title: "Intercept everything")]
    var store: Store<AppState>!

    override func setUp() {
        super.setUp()
        store = Store(initialState: AppState())
    }

    func testTodos() throws {
        let view = TodoListView(model: .init(store: store), todos: todos)
        let row4 = try view.inspect().list().forEach(0).anyView(0).view(TodoRowView.self).actualView()
        XCTAssertEqual(row4.todo, todos[0])
    }

    func testNoTodos() throws {
        let view = TodoListView(model: .init(store: store))
        let text = try view.inspect().list().text(0)
        XCTAssertEqual(try text.string(), "No todos")
    }
}

extension TodoListView: Inspectable {}
extension TodoRowView: Inspectable {}
