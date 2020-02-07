//
//  UserDetailViewController.swift
//  Viper
//
//  Created by Masanao Imai on 2020/02/07.
//
import UIKit

final class UserDetailViewController: UIViewController, View {
    // MARK: - View

    typealias Event = UserDetailViewEvent
    typealias Command = UserDetailPresenterCommand

    var eventListener: AnyEventListener<UserDetailViewEvent>?

    func handle(command: UserDetailPresenterCommand) {
        switch command {
        case let .reload(list):
            reload(list: list)
        case let .showError(title, message):
            showAlert(title: title, message: message)
        }
    }

    // MARK: - IBOutlet

    @IBOutlet private var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 64
            tableView.rowHeight = UITableView.automaticDimension
            tableView.register(cellType: RepositoryCell.self)
        }
    }

    // MARK: - Private Properties

    private var repositories: [Repository] = []

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        eventListener?.handle(event: .viewDidLoad)
    }
}

private extension UserDetailViewController {
    func reload(list: [Repository]) {
        repositories = list
        tableView.reloadData()
    }
}

extension UserDetailViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        repositories.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as RepositoryCell
        if let repository = repository(forRow: indexPath.row) {
            cell.configure(repository: repository)
        }
        return cell
    }

    private func repository(forRow row: Int) -> Repository? {
        guard row < repositories.count else { return nil }
        return repositories[row]
    }
}
