//
//  Images.swift
//  NewTableApp
//
//  Created by Ilya Zhdaney on 19.07.2021.
//

import Foundation


struct PhotosResult: Codable {
    let arraySrc: [String: String]

    enum CodingKeys: String, CodingKey {
        case arraySrc = "src"
    }
}

struct ApiResponse: Codable {
    let photos: [PhotosResult]
    
    enum CodingKeys: String, CodingKey {
        case photos = "photos"
    }
}

