//
//  UserDetailRouter.swift
//  Viper2
//
//  Created by Masanao Imai on 2020/02/08.
//

import UIKit

protocol UserDetailWireframe: AnyObject {}

final class UserDetailRouter {
    private unowned let viewController: UIViewController

    private init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModules(userName: String) -> UIViewController {
        let vc = UserDetailViewController()
        let router = UserDetailRouter(viewController: vc)
        let userDetailInteractor = UserDetailInteractor()
        let presenter = UserDetailPresenter(view: vc, router: router, userDetailInteractor: DispatchMainQueueDecorator(userDetailInteractor), userName: userName)
        vc.presenter = presenter
        return vc
    }
}

extension UserDetailRouter: UserDetailWireframe {}
