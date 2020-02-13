//
//  SearchUserRouter.swift
//  Viper2
//
//  Created by Masanao Imai on 2020/02/08.
//

import UIKit

protocol SearchUserWireframe: AnyObject {
    func showUserDetail(userName: String)
}

final class SearchUserRouter {
    private unowned let viewController: UIViewController

    private init(viewController: UIViewController) {
        self.viewController = viewController
    }

    static func assembleModules() -> UIViewController {
        let vc = SearchUserViewController()
        let router = SearchUserRouter(viewController: vc)
        let searchUserInteractor = SearchUserInteractor()
        let presenter = SearchUserPresenter(view: vc, router: router, searchUserInteractor: DispatchMainQueueDecorator(searchUserInteractor))
        vc.presenter = presenter
        return vc
    }
}

extension SearchUserRouter: SearchUserWireframe {
    func showUserDetail(userName: String) {
        let vc = UserDetailRouter.assembleModules(userName: userName)
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
}
