//
//  UIViewController+Alert.swift
//  Viper
//
//  Created by Masanao Imai on 2020/02/07.
//

import UIKit

extension UIViewController {
    func showAlert(title: String?, message: String?) {
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        showAlert(title: title, message: message, actions: [okAction])
    }

    func showErrorAlert(message: String) {
        showAlert(title: "エラー", message: message)
    }

    func showAlert(title: String?, message: String?, actions: [UIAlertAction]? = nil, handler: ((UIAlertAction) -> Void)? = nil) {
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = .crossDissolve

        if let actions = actions {
            actions.forEach { action in
                controller.addAction(action)
            }
        } else {
            let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)
            controller.addAction(okAction)
        }

        present(controller, animated: true, completion: nil)

        return
    }
}
