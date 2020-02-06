//
//  UserCell.swift
//  MVPSample
//
//  Created by Kenji Tanaka on 2018/09/23.
//  Copyright © 2018年 Kenji Tanaka. All rights reserved.
//

import Reusable
import UIKit

final class UserCell: UITableViewCell, NibReusable {
    @IBOutlet private var iconImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!

    private var task: URLSessionTask?

    override func prepareForReuse() {
        super.prepareForReuse()

        task?.cancel()
        task = nil
        imageView?.image = nil
    }

    func configure(user: User) {
        task = {
            let url = user.avatarURL
            let task = URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let imageData = data else {
                    return
                }

                DispatchQueue.global().async { [weak self] in
                    guard let image = UIImage(data: imageData) else {
                        return
                    }

                    DispatchQueue.main.async {
                        self?.iconImageView?.image = image
                        self?.setNeedsLayout()
                    }
                }
            }
            task.resume()
            return task
        }()

        nameLabel.text = user.login
    }
}
