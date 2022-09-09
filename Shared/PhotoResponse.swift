//
//  PhotoResponse.swift
//  woodycamera
//
//  Created by 颜松柏 on 2022/9/6.
//

import Foundation

struct PhotoResponse: Codable {
    var models: [ModelResponse]
}

struct ModelResponse: Codable {
    var index: Int
    var urls: [String]
    var modelName: String
    var city: String
    var tags: [String]
    var date: String
}
