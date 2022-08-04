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


// MARK: - RateLimit
struct RateLimit: Codable {
}
