/*
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2021
 *  MIT license, see LICENSE file for details
 */

import SwiftUI

@main
struct TodoApp: App {
    static var store = createStore()

    var body: some Scene {
        WindowGroup {
            RootView(store: TodoApp.store)
        }
    }
}
