//
//  DispatchMainQueueDecorator.swift
//  Viper2
//
//  Created by Masanao Imai on 2020/02/13.
//

import Foundation

// Decorator Pattern
// Ensure that it runs on the main thread
// https://qiita.com/shiz/items/75c6749edc08dcbcb158
final class DispatchMainQueueDecorator<T> {
    let decoratee: T

    init(_ decoratee: T) {
        self.decoratee = decoratee
    }

    /// Run on main thread
    /// - Parameter completion: processing of a wrapped class
    func dispatch(completion: @escaping () -> Void) {
        guard Thread.isMainThread else {
            return DispatchQueue.main.async(execute: completion)
        }
        completion()
    }
}
