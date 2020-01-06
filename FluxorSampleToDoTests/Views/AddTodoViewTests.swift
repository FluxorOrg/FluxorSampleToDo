/**
 * FluxorSampleToDoTests
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

@testable import FluxorSampleToDoSwiftUI
import ViewInspector
import XCTest

// ViewInspector can't inspect the view because of the .navigationBarItems
// class AddTodoViewTests: XCTestCase {
//    func testTodos() throws {
//        let view = AddTodoView(showAddSheet: .constant(true))
//        let textField = try view.inspect().navigationView().form(0).textField(0)
//        print(textField)
//    }
// }

extension AddTodoView: Inspectable {}
