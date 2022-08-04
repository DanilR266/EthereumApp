//
//  StructRequest.swift
//  EthApp
//
//  Created by Данила on 02.08.2022.
//

import Foundation

// MARK: - Welcome
struct Welcome: Codable {
    let usd: Double?

    enum CodingKeys: String, CodingKey {
        case usd = "USD"
    }
}


struct WelcomeSec: Codable {
    let response, message: String?
    let hasWarning: Bool?
    let type: Int?
    let rateLimit: RateLimit?
    let data: DataClass?

    enum CodingKeys: String, CodingKey {
        case response = "Response"
        case message = "Message"
        case hasWarning = "HasWarning"
        case type = "Type"
        case rateLimit = "RateLimit"
        case data = "Data"
    }
}

// DataClass.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let dataClass = try? newJSONDecoder().decode(DataClass.self, from: jsonData)

// MARK: - DataClass
struct DataClass: Codable {
    let aggregated: Bool?
    let timeFrom, timeTo: Int?
    let data: [Datum]?

    enum CodingKeys: String, CodingKey {
        case aggregated = "Aggregated"
        case timeFrom = "TimeFrom"
        case timeTo = "TimeTo"
        case data = "Data"
    }
}

// Datum.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let datum = try? newJSONDecoder().decode(Datum.self, from: jsonData)


// MARK: - Datum
struct Datum: Codable {
    let time: Int?
    let high, low, datumOpen, volumefrom: Double?
    let volumeto, close: Double?
    let conversionType, conversionSymbol: String?

    enum CodingKeys: String, CodingKey {
        case time, high, low
        case datumOpen = "open"
        case volumefrom, volumeto, close, conversionType, conversionSymbol
    }
}

// RateLimit.swift

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let rateLimit = try? newJSONDecoder().decode(RateLimit.self, from: jsonData)


// MARK: - RateLimit
struct RateLimit: Codable {
}
