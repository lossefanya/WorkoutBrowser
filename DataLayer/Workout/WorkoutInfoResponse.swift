//
//  WorkoutResponse.swift
//  WorkoutBrowser
//
//  Created by Yeongweon Park on 27.01.24.
//

import Foundation

struct WorkoutResponse: Decodable {
    let results: [WorkoutInfoResponse]
}

struct WorkoutInfoResponse: Decodable {
    let id: Int
    let name: String
    let uuid: String
    let description: String
    let images: [ImageResponse]
    let variations: [Int]
}

struct ImageResponse: Decodable {
    let id: Int
    let image: String
}

extension WorkoutInfoResponse {
    var descWithDefault: String {
        description.count == 0 ? "No Contents" : description
    }
    
    var asEntity: WorkoutEntity {
        WorkoutEntity(
            id: id,
            name: name,
            uuid: uuid,
            description: descWithDefault.asAttributedString,
            images: images.map { $0.image },
            variations: variations
        )
    }
}
