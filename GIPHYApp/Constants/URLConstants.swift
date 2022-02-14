//
//  URLConstants.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/13.
//

import Foundation

struct URLConstant {
    private enum Domains {
        static let Giphy = "https://api.giphy.com/v1"
    }

    private enum URI {
        static let SEARCH_IMAGE = "/gifs/search"
        static let SEARCH_STICKER = "/stickers/search"
        static let TRENDING_IMAGE = "/gifs/trending"
        static let TRENDING_SEARCHES = "/trending/searches"
    }

    static var SearchImageURL: String {
        return Domains.Giphy + URI.SEARCH_IMAGE
    }
    
    static var SearchStickerURLL: String {
        return Domains.Giphy + URI.SEARCH_STICKER
    }
    
    static var TrendingImageURL : String {
        return Domains.Giphy + URI.TRENDING_IMAGE
    }
    
    static var TrendingSearchURL : String {
        return Domains.Giphy + URI.TRENDING_SEARCHES
    }
    
}
