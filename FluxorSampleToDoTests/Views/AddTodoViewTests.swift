//
//  AddTodoViewTests.swift
//  FluxorSampleToDoTests
//
//  Created by Morten Bjerg Gregersen on 13/12/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

@testable import FluxorSampleToDo
import ViewInspector
import XCTest

// ViewInspector can't inspect the view because of the .navigationBarItems
//class AddTodoViewTests: XCTestCase {
//    func testTodos() throws {
//        let view = AddTodoView(showAddSheet: .constant(true))
//        let textField = try view.inspect().navigationView().form(0).textField(0)
//        print(textField)
//    }
//}

extension AddTodoView: Inspectable {}
