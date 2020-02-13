//
//  UserDetailPresenter.swift
//  Viper
//
//  Created by Masanao Imai on 2020/02/07.
//
import Foundation

protocol UserDetailPresentation: AnyObject {
    func viewDidLoad()
}

final class UserDetailPresenter {
    private var userName: String
    private weak var view: UserDetailView?
    private let router: UserDetailWireframe
    private let userDetailInteractor: UserDetailUsecase
    init(view: UserDetailView, router: UserDetailWireframe, userDetailInteractor: UserDetailUsecase, userName: String) {
        self.view = view
        self.router = router
        self.userDetailInteractor = userDetailInteractor
        self.userName = userName
    }
}

// MARK: - UserDetailPresentation

extension UserDetailPresenter: UserDetailPresentation {
    func viewDidLoad() {
        userDetailInteractor.fetchList(userName: userName) { [weak self] result in
            switch result {
            case let .success(repositories):
                self?.view?.reload(list: repositories)
            case let .failure(error):
                self?.view?.showError(title: error.localizedDescription, message: nil)
            }
        }
    }
}
