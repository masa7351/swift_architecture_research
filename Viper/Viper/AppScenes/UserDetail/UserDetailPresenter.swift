//
//  UserDetailPresenter.swift
//  Viper
//
//  Created by Masanao Imai on 2020/02/07.
//
import Foundation

final class UserDetailPresenter: Presenter {
    typealias Event = UserDetailViewEvent
    typealias Command = UserDetailPresenterCommand
    typealias Request = UserDetailInteractorRequest
    typealias Response = UserDetailInteractorResponse

    var requestListener: AnyRequestListener<UserDetailInteractorRequest>?
    var commandListener: AnyCommandListener<UserDetailPresenterCommand>?
    var router: Router?
    var scenePresenter: ScenePresenter?

    private var userName: String
    init(userName: String) {
        self.userName = userName
    }

    func handle(event: UserDetailViewEvent) {
        switch event {
        case .viewDidLoad:
            viewDidLoad()
        }
    }

    func handle(response: UserDetailInteractorResponse) {
        switch response {
        case let .listReceived(result):
            listReceive(result: result)
        }
    }
}

// MARK: - ViewEvent

private extension UserDetailPresenter {
    func viewDidLoad() {
        requestListener?.handle(request: .fetchList(userName: userName))
    }
}

// MARK: - Response

private extension UserDetailPresenter {
    func listReceive(result: Result<[Repository]>) {
        switch result {
        case let .success(repositories):
            commandListener?.handle(command: .reload(list: repositories))
        case let .failure(error):
            commandListener?.handle(command: .showError(title: error.localizedDescription, message: nil))
        }
    }
}
