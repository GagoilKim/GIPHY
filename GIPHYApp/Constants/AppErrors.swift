//
//  AppErrors.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/13.
//

import Foundation

enum AppErrors: Error {
    case networkError
    case requestError
    case decodeError
    case encodeError
}
