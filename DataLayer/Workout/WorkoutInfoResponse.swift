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
    let uuid: String
    let images: [ImageResponse]
    let translations: [TranslationResponse]
    let variationGroup: String?

    enum CodingKeys: String, CodingKey {
        case id
        case uuid
        case images
        case translations
        case variationGroup = "variation_group"
    }
}

struct ImageResponse: Decodable {
    let id: Int
    let image: String
}

struct TranslationResponse: Decodable {
    let name: String
    let description: String?
}

extension WorkoutInfoResponse {
    private var preferredTranslation: TranslationResponse? {
        translations.first(where: { !$0.name.isEmpty || !($0.description ?? "").isEmpty })
    }

    var nameWithDefault: String {
        guard let name = preferredTranslation?.name, !name.isEmpty else {
            return "Unknown Workout"
        }

        return name
    }

    var descWithDefault: String {
        guard let description = preferredTranslation?.description, !description.isEmpty else {
            return "No Contents"
        }

        return description
    }

    func asEntity(variations: [Int] = []) -> WorkoutEntity {
        WorkoutEntity(
            id: id,
            name: nameWithDefault,
            uuid: uuid,
            description: descWithDefault.asAttributedString,
            images: images.map { $0.image },
            variations: variations
        )
    }
}
