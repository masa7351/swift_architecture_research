//
//  SearchUserViewController.swift
//  Viper
//
//  Created by Masanao Imai on 2020/02/07.
//

import UIKit

final class SearchUserViewController: UIViewController, View {
    // MARK: - View

    var eventListener: AnyEventListener<SearchUserViewEvent>?

    func handle(command: SearchUserPresenterCommand) {
        switch command {
        case let .reload(list):
            reload(list: list)
        case .showNoContent:
            showNoContent()
        case let .showError(title, message):
            showAlert(title: title, message: message)
        }
    }

    typealias Event = SearchUserViewEvent
    typealias Command = SearchUserPresenterCommand

    // MARK: - IBOutlet

    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 80
            tableView.rowHeight = UITableView.automaticDimension
            tableView.register(cellType: UserCell.self)
        }
    }

    // MARK: - Private Properties

    private var users: [User] = []

    fileprivate func user(forRow row: Int) -> User? {
        guard row < users.count else { return nil }
        return users[row]
    }
}

// MARK: - View

extension SearchUserViewController {
    func reload(list: [User]) {
        users = list
        tableView.isHidden = false
        tableView.reloadData()
    }

    func showNoContent() {
        tableView.isHidden = true
    }
}

// MARK: - ScenePresenter

extension SearchUserViewController: ScenePresenter {
    func present(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UISearchBarDelegate

extension SearchUserViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        eventListener?.handle(event: .didTapSearchButton(text: text))
        searchBar.resignFirstResponder()
    }
}

// MARK: - UITableViewDelegate

extension SearchUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let user = user(forRow: indexPath.row) {
            eventListener?.handle(event: .didSelect(user: user))
        }
    }
}

// MARK: - UITableViewDataSource

extension SearchUserViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        users.count
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as UserCell

        if let user = user(forRow: indexPath.row) {
            cell.configure(user: user)
        }

        return cell
    }
}
