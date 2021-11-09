/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Fluxor
import SwiftUI

struct RootView: View {
    @ObservedObject var store: Store<AppState, AppEnvironment>

    var body: some View {
        NavigationView {
            TodoListView(store: store)
                .toolbar {
                    Button("Add") {
                        store.dispatch(action: NavigationActions.showAddSheet())
                    }
                }
        }
        .navigationViewStyle(.stack)
        .inspectableSheet(isPresented: store.binding(get: NavigationSelectors.shoulShowAddShet, enable: NavigationActions.showAddSheet, disable: NavigationActions.hideAddSheet)) {
            AddTodoView(store: store)
        }
    }
}

#if !TESTING
struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(store: previewStore)
    }
}
#endif
