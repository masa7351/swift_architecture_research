//
//  AppScene.swift
//  Viper
//
//  Created by Masanao Imai on 2020/02/07.
//

import UIKit

enum AppScene: Scene {
    case searchUser
    case userDetail(user: User)

    var viewController: UIViewController {
        switch self {
        case .searchUser:
            return configureSearchUser()
        case let .userDetail(user):
            return configureUserDetail(user)
        }
    }

    private func configureSearchUser() -> UIViewController {
        let vc = StoryboardScene.SearchUser.initialScene.instantiate()
        let presenter = SearchUserPresenter()
        let interactor = SearchUserInteractor()
        build(view: vc, presenter: presenter, interactor: interactor, scenePresenter: vc)
        return UINavigationController(rootViewController: vc)
    }

    private func configureUserDetail(_ user: User) -> UIViewController {
        let userName = user.login
        let vc = StoryboardScene.UserDetail.initialScene.instantiate()
        let presenter = UserDetailPresenter(userName: userName)
        let interactor = UserDetailInteractor()
        build(view: vc, presenter: presenter, interactor: interactor, scenePresenter: nil)
        return vc
    }
}
