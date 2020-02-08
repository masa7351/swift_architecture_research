//
//  UserDetailInteractor.swift
//  Viper
//
//  Created by Masanao Imai on 2020/02/07.
//

import Foundation

protocol UserDetailUsecase: AnyObject {
    func fetchList(userName: String, completion: @escaping (Result<[Repository]>) -> Void)
}

final class UserDetailInteractor {}

extension UserDetailInteractor: UserDetailUsecase {
    func fetchList(userName: String, completion: @escaping (Result<[Repository]>) -> Void) {
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
