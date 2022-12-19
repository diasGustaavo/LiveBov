//
//  StockData.swift
//  LiveBov
//
//  Created by Gustavo Dias on 19/12/22.
//

import Foundation

struct StockData: Codable {
    let results: [Details]
}

struct Details: Codable {
    let symbol: String
    let longName: String
    let regularMarketOpen: Float
    let regularMarketPrice: Float
    let fiftyTwoWeekLow: Float
    let fiftyTwoWeekHigh: Float
    let priceEarnings: Float?
    let earningsPerShare: Float?
}
