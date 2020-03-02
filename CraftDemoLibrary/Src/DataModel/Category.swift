//
//  Category.swift
//  CraftDemoLibrary
//
//  Created by Suhail on 19/02/20.
//  Copyright © 2020 Suhail. All rights reserved.
//

import Foundation

// MARK: - Category
struct Category: Codable {
    let minValue, maxValue, rank, percentage: Int
    let color: String

    enum CodingKeys: String, CodingKey {
        case minValue = "min_value"
        case maxValue = "max_value"
        case rank, percentage, color
    }
}

// MARK: Category convenience initializers and mutators

extension Category {
    init(data: Data) throws {
        self = try JSONDecoder().decode(Category.self, from: data)
    }

    init(_ json: String, using encoding: String.Encoding = .utf8) throws {
        guard let data = json.data(using: encoding) else {
            throw NSError(domain: "JSONDecoding", code: 0, userInfo: nil)
        }
        try self.init(data: data)
    }

    init(fromURL url: URL) throws {
        try self.init(data: try Data(contentsOf: url))
    }

    func with(
        minValue: Int? = nil,
        maxValue: Int? = nil,
        rank: Int? = nil,
        percentage: Int? = nil,
        color: String? = nil
    ) -> Category {
        return Category(
            minValue: minValue ?? self.minValue,
            maxValue: maxValue ?? self.maxValue,
            rank: rank ?? self.rank,
            percentage: percentage ?? self.percentage,
            color: color ?? self.color
        )
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}

extension Category: Equatable {
    static func == (lhs: Category, rhs: Category) -> Bool {
        return lhs.rank == rhs.rank
    }
}
