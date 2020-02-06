//
// Created by Kenji Tanaka on 2018/09/24.
// Copyright (c) 2018 Kenji Tanaka. All rights reserved.
//

import Foundation

protocol SearchUserModelInput {
    func fetchUser(
        query: String,
        completion: @escaping (Result<[User]>) -> Void
    )
}

final class SearchUserModel: SearchUserModelInput {
    func fetchUser(
        query: String,
        completion: @escaping (Result<[User]>) -> Void
    ) {
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
