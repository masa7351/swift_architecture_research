//
//  SearchUserPresenter.swift
//  Viper
//
//  Created by Masanao Imai on 2020/02/07.
//

import Foundation

protocol SearchUserPresentation: AnyObject {
    func didTapSearchButton(text: String)
    func didSelect(user: User)
}

final class SearchUserPresenter {
    private weak var view: SearchUserView?
    private let router: SearchUserWireframe
    private let searchUserInteractor: SearchUserUsecase

    init(view: SearchUserView, router: SearchUserWireframe, searchUserInteractor: SearchUserUsecase) {
        self.view = view
        self.router = router
        self.searchUserInteractor = searchUserInteractor
    }
}

extension SearchUserPresenter: SearchUserPresentation {
    func didSelect(user: User) {
        router.showUserDetail(userName: user.login)
    }

    func didTapSearchButton(text: String) {
        searchUserInteractor.fetchList(query: text) { [weak self] result in
            switch result {
            case let .success(users):
                if users.isEmpty {
                    self?.view?.showNoContent()
                } else {
                    self?.view?.reload(list: users)
                }
            case let .failure(error):
                self?.view?.showError(title: error.localizedDescription, message: nil)
            }
        }
    }
}
