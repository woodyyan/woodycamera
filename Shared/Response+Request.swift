//
//  PhotoResponse.swift
//  woodycamera
//
//  Created by 颜松柏 on 2022/9/6.
//

import Foundation

struct CollectionsResponse: Codable {
    var collections: [CollectionResponse]
}

struct CollectionResponse: Codable {
    var urls: [UrlItem]
    var modelName: String
    var city: String
    var tags: [String]
    var date: String
}

struct UrlItem: Codable {
    var photoId: Int
    var url: String
}

//struct LoginRequest: Codable {
//    var email: String
//    var familyName: String
//    var givenName: String
//    var userId: String
//}

struct LoginResponse: Codable {
    var email: String
    var familyName: String
    var givenName: String
    var userId: String
}
