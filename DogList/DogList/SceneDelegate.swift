//
//  SceneDelegate.swift
//  DogList
//
//  Created by Alejandro Rodriguez on 06/06/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController = UINavigationController(rootViewController: ListRouter.createModule())
        window?.makeKeyAndVisible()
    }

}
