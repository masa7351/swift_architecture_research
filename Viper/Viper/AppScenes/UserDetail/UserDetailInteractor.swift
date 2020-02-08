//
//  UserDetailInteractor.swift
//  Viper
//
//  Created by Masanao Imai on 2020/02/07.
//

import Foundation

final class UserDetailInteractor: Interactor {
    typealias Request = UserDetailInteractorRequest
    typealias Response = UserDetailInteractorResponse

    var responseListener: AnyResponseListener<UserDetailInteractorResponse>?

    func handle(request: UserDetailInteractorRequest) {
        switch request {
        case let .fetchList(userName):
            fetchList(userName)
        }
    }

    private func fetchList(_ userName: String) {
        let session = Session()
        let request = UserReposRequest(username: userName, type: nil, sort: nil, direction: nil, page: nil, perPage: nil)
        session.send(request) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    self?.responseListener?.handle(response: .listReceived(result: .success(response.0)))
                case let .failure(error):
                    self?.responseListener?.handle(response: .listReceived(result: .failure(error)))
                }
            }
        }
    }
}
