//
//  SceneDelegate.swift
//  FluxorSampleToDo
//
//  Created by Morten Bjerg Gregersen on 19/11/2019.
//  Copyright © 2019 MoGee. All rights reserved.
//

import Combine
import Fluxor
import SwiftUI
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}
