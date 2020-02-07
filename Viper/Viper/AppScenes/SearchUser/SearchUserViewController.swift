//
//  SearchUserViewController.swift
//  MVPSample
//
//  Created by Kenji Tanaka on 2018/09/23.
//  Copyright © 2018年 Kenji Tanaka. All rights reserved.
//

import UIKit

final class SearchUserViewController: UIViewController {
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 80
            tableView.rowHeight = UITableView.automaticDimension
            tableView.register(cellType: UserCell.self)
        }
    }

    private var presenter: SearchUserPresenterInput!
    func inject(presenter: SearchUserPresenterInput) {
        self.presenter = presenter
    }

    static func instantiate() -> SearchUserViewController {
        let searchUserViewController = StoryboardScene.SearchUser.initialScene.instantiate()
        let model = SearchUserModel()
        let presenter = SearchUserPresenter(view: searchUserViewController, model: model)
        searchUserViewController.inject(presenter: presenter)
        return searchUserViewController
    }
}

extension SearchUserViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.didTapSearchButton(text: searchBar.text)
    }
}

extension SearchUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectRow(at: indexPath)
    }
}

extension SearchUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfUsers
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as UserCell

        if let user = presenter.user(forRow: indexPath.row) {
            cell.configure(user: user)
        }

        return cell
    }
}

extension SearchUserViewController: SearchUserPresenterOutput {
    func updateUsers(_ users: [User]) {
        tableView.reloadData()
    }

    func transitionToUserDetail(userName: String) {
        let userDetailVC = StoryboardScene.UserDetail.initialScene.instantiate()
        let model = UserDetailModel(userName: userName)
        let presenter = UserDetailPresenter(
            userName: userName,
            view: userDetailVC,
            model: model
        )
        userDetailVC.inject(presenter: presenter)

        navigationController?.pushViewController(userDetailVC, animated: true)
    }
}
