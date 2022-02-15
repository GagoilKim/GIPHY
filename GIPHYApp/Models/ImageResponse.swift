//
//  ImageResponse.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/13.
//

import Foundation

struct ImageResponse : Decodable {
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
    var downSized : ImageData
    
    private enum CodingKeys: String, CodingKey {
        case original
        case downSized  = "downsized"
    }
}

struct ImageData : Decodable {
    var height : String
    var width : String
    var url : String
}
