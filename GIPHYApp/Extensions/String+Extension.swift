//
//  String+Extension.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/13.
//

import Foundation
import UIKit

extension String {
    func encodeUrl() -> String {
        guard let encodedURL = addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return "" }
        return encodedURL
    }
}
