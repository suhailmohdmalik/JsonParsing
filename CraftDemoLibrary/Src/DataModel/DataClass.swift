//
//  DataClass.swift
//  CraftDemoLibrary
//
//  Created by Suhail on 19/02/20.
//  Copyright © 2020 Suhail. All rights reserved.
//

import Foundation

// MARK: - DataClass
struct DataClass: Codable {
    let score, timestamp: Int
    let categories: [Category]

    enum CodingKeys: String, CodingKey {
        case score, timestamp, categories
    }
}

// MARK: DataClass convenience initializers and mutators

extension DataClass {
    init(data: Data) throws {
        self = try JSONDecoder().decode(DataClass.self, from: data)
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
        score: Int? = nil,
        timestamp: Int? = nil,
        categories: [Category]? = nil
    ) -> DataClass {
        let sortedCategories = categories?.sorted(by: { $0.rank < $1.rank})
        return DataClass(
            score: score ?? self.score,
            timestamp: timestamp ?? self.timestamp,
            categories: sortedCategories ?? self.categories
        )
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
