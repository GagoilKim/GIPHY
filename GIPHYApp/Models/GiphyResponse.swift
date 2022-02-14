//
//  GiphyResponse.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/13.
//

import Foundation

struct GiphyResponse : Decodable {
    var data: [DataObject]
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
}

struct DataObject : Decodable, Identifiable {
    var imagesList:  ImageObject
    var id = UUID()
    
    private enum CodingKeys: String, CodingKey {
        case imagesList = "images"
    }
    
}

struct ImageObject : Decodable {
    var original : ImageData
    var preview : ImageData
    var originalStill : ImageData
    var downSized : ImageData
    
    private enum CodingKeys: String, CodingKey {
        case original
        case preview = "preview_gif"
        case originalStill = "original_still"
        case downSized  = "downsized"
    }
}

struct ImageData : Decodable {
    var height : String
    var width : String
    var url : String
}
