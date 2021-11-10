/*
 * FluxorSampleToDo
 *  Copyright (c) Morten Bjerg Gregersen 2020
 *  MIT license, see LICENSE file for details
 */

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let navC = UINavigationController(rootViewController:
                TodoListViewController(collectionViewLayout: UICollectionViewFlowLayout()))
            navC.navigationBar.prefersLargeTitles = true
            window.rootViewController = navC
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
