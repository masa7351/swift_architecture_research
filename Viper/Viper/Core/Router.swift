//
//  Router.swift
//  Viper
//
//  Created by Masanao Imai on 2020/02/06.
//

import UIKit

class Router {
    func present(scene: Scene, scenePresenter: ScenePresenter) {
        let viewController = scene.viewController
        scenePresenter.present(viewController: viewController)
    }
}
