/**
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import Fluxor
import FluxorExplorerInterceptor
import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    let store: Store<AppState, AppEnvironment> = {
        let store = Store(initialState: AppState(), environment: AppEnvironment())
        store.register(reducer: todoReducer, for: \.todo)
        store.register(reducer: navigationReducer, for: \.navigation)
        store.register(effects: TodosEffects())
        #if DEBUG
        store.register(interceptor: PrintInterceptor())
        store.register(interceptor: FluxorExplorerInterceptor(displayName: UIDevice.current.name))
        #endif
        return store
    }()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            StorePropertyWrapper.addStore(store)
            let rootView = RootView().environmentObject(store)
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: rootView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
