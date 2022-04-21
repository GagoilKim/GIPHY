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
    
    var gifsBackColor : Color {
        switch self {
        case .GIFs:
            return Color.purple
        case .Stickers:
            return Color.black
        }
    }
    
    var stickerBackColor : Color {
        switch self {
        case .GIFs:
            return Color.black
        case .Stickers:
            return Color.mint
        }
    }
    
    var buttonColor : Color {
        switch self {
        case .GIFs:
            return Color.purple
        case .Stickers:
            return Color.mint
        }
    }
}


enum ImageSelectStatus: Equatable {
    case selected
    case notSelected
}
