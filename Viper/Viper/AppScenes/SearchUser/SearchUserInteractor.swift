//
//  SearchUserInteractor.swift
//  Viper
//
//  Created by Masanao Imai on 2020/02/07.
//

import Foundation

final class SearchUserInteractor: Interactor {
    typealias Response = SearchUserInteracotrResponse
    typealias Request = SearchUserInteractorRequest

    var responseListener: AnyResponseListener<SearchUserInteracotrResponse>?

    func handle(request: SearchUserInteractorRequest) {
        switch request {
        case let .fetchList(query):
            fetchList(query: query)
        }
    }

    private func fetchList(query: String) {
        let session = Session()
        let request = SearchUsersRequest(
            query: query,
            sort: nil,
            order: nil,
            page: nil,
            perPage: nil
        )

        session.send(request) { result in
            DispatchQueue.main.async {
                switch result {
                case let .success(response):
                    self.responseListener?.handle(response: .listReceived(result: .success(response.0.items)))
                case let .failure(error):
                    self.responseListener?.handle(response: .listReceived(result: .failure(error)))
                }
            }
        }
    }
}
