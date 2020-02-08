//
//  Request.swift
//  GitHub
//
//  Created by 鈴木大貴 on 2018/08/02.
//  Copyright © 2018年 marty-suzuki. All rights reserved.
//

import Foundation

public protocol Request {
    associatedtype Response: Decodable
    var baseURL: URL { get }
    var method: HttpMethod { get }
    var path: String { get }
    var headerFields: [String: String] { get }
    var queryParameters: [String: String]? { get }
}

extension Request {
    public var baseURL: URL {
        URL(string: "https://api.github.com")!
    }

    public var headerFields: [String: String] {
        ["Accept": "application/json"]
    }

    public var queryParameters: [String: String]? {
        nil
    }
}

public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
}
