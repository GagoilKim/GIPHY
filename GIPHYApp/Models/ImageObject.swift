//
//  ImageObject.swift
//  GIPHYApp
//
//  Created by KyleKim on 2022/03/30.
//

import Foundation

struct ImageDataObject : Decodable, Identifiable {
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
