//
//  URLConstants.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/13.
//

import Foundation

struct URLConstant {
    private enum Domains {
        static let Giphy = "https://api.giphy.com/v1/gifs"
    }

    private enum URI {
        static let SEARCH_IMAGE = "/search"
    }

    static var SearchImageURL: String {
        return Domains.Giphy + URI.SEARCH_IMAGE
    }
}
