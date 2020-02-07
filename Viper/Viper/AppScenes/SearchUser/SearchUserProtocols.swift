//
//  SearchUserProtocols.swift
//  Viper
//
//  Created by Masanao Imai on 2020/02/07.
//

import Foundation

enum SearchUserPresenterCommand: PresenterCommand {
    case reload(list: [User])
    case showError(title: String, message: String?)
    case showNoContent
}

enum SearchUserViewEvent: ViewEvent {
    case didTapSearchButton(text: String)
    case didSelect(user: User)
}

enum SearchUserInteractorRequest: InteractorRequest {
    case fetchList(query: String)
}

enum SearchUserInteracotrResponse: InteractorResponse {
    case listReceived(result: Result<[User]>)
}
