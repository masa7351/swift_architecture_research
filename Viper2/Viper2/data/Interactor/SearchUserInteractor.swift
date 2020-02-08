//
//  SearchUserInteractor.swift
//  Viper
//
//  Created by Masanao Imai on 2020/02/07.
//

import Foundation

protocol SearchUserUsecase: AnyObject {
    func fetchList(query: String, completion: @escaping (Result<[User]>) -> Void)
}

final class SearchUserInteractor {
    // TODO: can change mock
}

extension SearchUserInteractor: SearchUserUsecase {
    func fetchList(query: String, completion: @escaping (Result<[User]>) -> Void) {
        let session = Session()
        let request = SearchUsersRequest(
            query: query,
            sort: nil,
            order: nil,
            page: nil,
            perPage: nil
        )
        session.send(request) { result in
            switch result {
            case let .success(response):
                completion(.success(response.0.items))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
