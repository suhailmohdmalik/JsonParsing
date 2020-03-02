//
//  ResponseData.swift
//  CraftDemoLibrary
//
//  Created by Suhail on 19/02/20.
//  Copyright © 2020 Suhail. All rights reserved.
//


import Foundation

// MARK: - Welcome
struct ResponseData: Codable {
    let data: DataClass

    enum CodingKeys: String, CodingKey {
        case data
    }
}

extension ResponseData {
    init(data: Data) throws {
        self = try JSONDecoder().decode(ResponseData.self, from: data)
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
        data: DataClass? = nil,
        errorCode: Int? = nil
    ) -> ResponseData {
        return ResponseData(
            data: data ?? self.data
        )
    }

    func jsonData() throws -> Data {
        return try JSONEncoder().encode(self)
    }

    func jsonString(encoding: String.Encoding = .utf8) throws -> String? {
        return String(data: try self.jsonData(), encoding: encoding)
    }
}
