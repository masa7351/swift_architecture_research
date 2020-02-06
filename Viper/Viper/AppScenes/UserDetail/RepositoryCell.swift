//
//  RepositoryCell.swift
//  MVPSample
//
//  Created by Kenji Tanaka on 2018/09/26.
//  Copyright © 2018年 Kenji Tanaka. All rights reserved.
//

import Reusable
import UIKit

final class RepositoryCell: UITableViewCell, NibReusable {
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!
    @IBOutlet private var languageLabel: UILabel!
    @IBOutlet private var starLabel: UILabel!
    @IBOutlet private var falkLabel: UILabel!

    func configure(repository: Repository) {
        nameLabel.text = repository.name
        descriptionLabel.text = repository.description
        languageLabel.text = repository.language
        starLabel.text = "star: \(repository.stargazersCount)"
        falkLabel.text = "falk: \(repository.forksCount)"
    }
}
