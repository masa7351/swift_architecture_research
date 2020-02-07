//
//  SearchUserPresenter.swift
//  Viper
//
//  Created by Masanao Imai on 2020/02/07.
//

import Foundation

final class SearchUserPresenter: Presenter {
    typealias Event = SearchUserViewEvent
    typealias Command = SearchUserPresenterCommand
    typealias Request = SearchUserInteractorRequest
    typealias Response = SearchUserInteracotrResponse

    var requestListener: AnyRequestListener<SearchUserInteractorRequest>?
    var commandListener: AnyCommandListener<SearchUserPresenterCommand>?
    var router: Router?
    var scenePresenter: ScenePresenter?

    func handle(event: SearchUserViewEvent) {
        switch event {
        case let .didTapSearchButton(text):
            didTapSearchButton(text)
        case let .didSelect(user):
            didSelect(user)
        }
    }

    func handle(response: SearchUserInteracotrResponse) {
        switch response {
        case let .listReceived(result):
            listReceived(result: result)
        }
    }
}

// MARK: - ViewEvent

private extension SearchUserPresenter {
    func didTapSearchButton(_ text: String) {
        requestListener?.handle(request: .fetchList(query: text))
    }

    func didSelect(_ user: User) {
        guard let presenter = scenePresenter else {
            return
        }
        router?.present(scene: AppScene.userDetail(user: user), scenePresenter: presenter)
    }
}

// MARK: - Response

extension SearchUserPresenter {
    private func listReceived(result: Result<[User]>) {
        switch result {
        case let .success(users):
            if users.isEmpty {
                commandListener?.handle(command: .showNoContent)
            } else {
                commandListener?.handle(command: .reload(list: users))
            }
        case let .failure(error):
            commandListener?.handle(command: .showError(title: error.localizedDescription, message: nil))
        }
    }
}
