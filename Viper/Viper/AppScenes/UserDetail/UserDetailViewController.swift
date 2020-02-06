//
// Created by Kenji Tanaka on 2018/09/24.
// Copyright (c) 2018 Kenji Tanaka. All rights reserved.
//

import UIKit

final class UserDetailViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!

    private var presenter: UserDetailPresenterInput!
    func inject(presenter: UserDetailPresenterInput) {
        self.presenter = presenter
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()

        presenter.viewDidLoad()
    }

    private func setup() {
        tableView.estimatedRowHeight = 64
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(cellType: RepositoryCell.self)
    }
}

extension UserDetailViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.repositories.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as RepositoryCell
        if let repository = presenter.repository(forRow: indexPath.row) {
            cell.configure(repository: repository)
        }
        return cell
    }
}

extension UserDetailViewController: UserDetailPresenterOutput {
    func updateRepositories(_ repositories: [Repository]) {
        tableView.reloadData()
    }
}