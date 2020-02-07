//
//  UserDetailProtocols.swift
//  Viper
//
//  Created by Masanao Imai on 2020/02/07.
//

import Foundation

enum UserDetailPresenterCommand: PresenterCommand {
    case reload(list: [Repository])
    case showError(title: String, message: String?)
}

enum UserDetailViewEvent: ViewEvent {
    case viewDidLoad
}

enum UserDetailInteractorRequest: InteractorRequest {
    case fetchList(userName: String)
}

enum UserDetailInteractorResponse: InteractorResponse {
    case listReceived(result: Result<[Repository]>)
}
