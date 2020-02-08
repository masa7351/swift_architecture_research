//
//  SearchUserViewController.swift
//  Viper
//
//  Created by Masanao Imai on 2020/02/07.
//

import UIKit

protocol SearchUserView: AnyObject {
    func reload(list: [User])
    func showError(title: String, message: String?)
    func showNoContent()
}

final class SearchUserViewController: UIViewController {
    var presenter: SearchUserPresentation!

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

extension SearchUserViewController: SearchUserView {
    func reload(list: [User]) {
        users = list
        tableView.isHidden = false
        tableView.reloadData()
    }

    func showError(title: String, message: String?) {
        showAlert(title: title, message: message)
    }

    func showNoContent() {
        tableView.isHidden = true
    }
}

// MARK: - UISearchBarDelegate

extension SearchUserViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        presenter.didTapSearchButton(text: text)
        searchBar.resignFirstResponder()
    }
}

// MARK: - UITableViewDelegate

extension SearchUserViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let user = user(forRow: indexPath.row) {
            presenter.didSelect(user: user)
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
