//
//  StockModel.swift
//  LiveBov
//
//  Created by Gustavo Dias on 19/12/22.
//

import Foundation

struct StockModel {
    let stockCode: String
    let stockName: String
    let openPrice: Float
    let currentPrice: Float
    let fiftyTwoWeekLow: Float
    let fiftyTwoWeekHigh: Float
    let priceEarnings: Float
    let earningsPerShare: Float
    
    var getOpenPriceStr: String {
        return String(openPrice)
    }
    
    var getOpenPercentStr: String {
        if (((openPrice - currentPrice) / currentPrice) * 100) > 0 {
            return "+" + String(format: "%.2f", ((openPrice - currentPrice) / currentPrice) * 100) + "%"
        }
        return String(format: "%.2f", ((openPrice - currentPrice) / currentPrice) * 100)
    }
    
    var getCurrentPriceStr: String {
        return String(currentPrice)
    }
    
    var getFiftyTwoWeekLowStr: String {
        return String(fiftyTwoWeekLow)
    }
    
    var getFiftyTwoWeekLowPercentStr: String {
        if (((fiftyTwoWeekLow - currentPrice) / currentPrice) * 100) > 0 {
            return "+" + String(format: "%.2f", ((fiftyTwoWeekLow - currentPrice) / currentPrice) * 100) + "%"
        }
        return String(format: "%.2f", ((fiftyTwoWeekLow - currentPrice) / currentPrice) * 100) + "%"
    }
    
    var getFiftyTwoWeekHighStr: String {
        return String(fiftyTwoWeekHigh)
    }
    
    var getFiftyTwoWeekHighPercentStr: String {
        if (((fiftyTwoWeekHigh - currentPrice) / currentPrice) * 100) > 0 {
            return "+" + String(format: "%.2f", ((fiftyTwoWeekHigh - currentPrice) / currentPrice) * 100) + "%"
        }
        return String(format: "%.2f", ((fiftyTwoWeekHigh - currentPrice) / currentPrice) * 100) + "%"
    }
    
    var getPriceEarningsStr: String {
        if priceEarnings != 0.0 {
            return String(format: "%.2f", priceEarnings)
        } else {
            return "Indisponível"
        }
    }
    
    var getEarningsPerShareStr: String {
        if earningsPerShare != 0.0 {
            return String(format: "%.2f", earningsPerShare)
        } else {
            return "Indisponível"
        }
    }
}
