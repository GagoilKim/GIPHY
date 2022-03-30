//
//  ImageResponse.swift
//  GIPHYApp
//
//  Created by Kyle Kim on 2022/02/13.
//

import Foundation

struct ImageResponse : Decodable {
    var data: [ImageDataObject]
    
    private enum CodingKeys: String, CodingKey {
        case data
    }
}

