//
// Created by Kenji Tanaka on 2018/09/26.
// Copyright (c) 2018 Kenji Tanaka. All rights reserved.
//

import Foundation

protocol UserDetailModelInput {
    func fetchRepositories(completion: @escaping (Result<[Repository]>) -> Void)
}

final class UserDetailModel: UserDetailModelInput {
    private let userName: String!
    init(userName: String) {
        self.userName = userName
    }

    func fetchRepositories(completion: @escaping (Result<[Repository]>) -> Void) {
        let session = Session()
        let request = UserReposRequest(username: userName, type: nil, sort: nil, direction: nil, page: nil, perPage: nil)
        session.send(request) { result in
            switch result {
            case let .success(response):
                completion(.success(response.0))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
