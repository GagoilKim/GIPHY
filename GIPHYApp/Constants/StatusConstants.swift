//
//  StatusConstants.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/15.
//

import Foundation
import SwiftUI

enum SearchType {
    case GIFs
    case Stickers
    
    var gifsTextColor : Color {
        switch self {
        case .GIFs:
            return Color.white
        case .Stickers:
            return Color.black
        }
    }
    
    var gifsBackColor : Color {
        switch self {
        case .GIFs:
            return Color.black
        case .Stickers:
            return Color.white
        }
    }
    
    var stickerTextColor : Color {
        switch self {
        case .GIFs:
            return Color.black
        case .Stickers:
            return Color.white
        }
    }
    
    var stickerBackColor : Color {
        switch self {
        case .GIFs:
            return Color.white
        case .Stickers:
            return Color.black
        }
    }
}


enum ImageSelectStatus: Equatable {
    case selected
    case notSelected
}
