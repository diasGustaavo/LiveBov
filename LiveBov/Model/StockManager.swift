//
//  StockManager.swift
//  LiveBov
//
//  Created by Gustavo Dias on 19/12/22.
//

import Foundation

protocol StockManagerDelegate {
    func didUpdateStock(_ stockManager: StockManager, stock: StockModel)
    func didFailWithError(error: Error)
}

class StockManager {
    let baseUrl = "https://brapi.dev/api/quote/"
    var delegate: StockManagerDelegate?
    var currentState = StockModel(stockCode: "PETR4", stockName: "Petróleo Brasileiro S.A. - Petrobras", openPrice: 21.96, currentPrice: 21.77, fiftyTwoWeekLow: 20.77, fiftyTwoWeekHigh: 38.39, priceEarnings: 1.62, earningsPerShare: 13.53)
    
    func fetchStock(with stockCode: String) {
        let safeStockCode = stockCode.removeWhitespace().uppercased()
        let urlString = "\(baseUrl)\(safeStockCode)?range=1d&interval=1d&fundamental=false%27"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        // 1. Create URL
        if let url = URL(string: urlString) {
            // 2. Create URLSession
            let session = URLSession(configuration: .default)
            
            // 3. Give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let stock = self.parseJSON(safeData) {
                        self.delegate?.didUpdateStock(self, stock: stock)
                    }
                }
            }
            
            // 4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ stockData: Data) -> StockModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(StockData.self, from: stockData)
            currentState = StockModel(stockCode: decodeData.results[0].symbol, stockName: decodeData.results[0].longName, openPrice: decodeData.results[0].regularMarketOpen, currentPrice: decodeData.results[0].regularMarketPrice, fiftyTwoWeekLow: decodeData.results[0].fiftyTwoWeekLow, fiftyTwoWeekHigh: decodeData.results[0].fiftyTwoWeekHigh, priceEarnings: decodeData.results[0].priceEarnings ?? 0.0, earningsPerShare: decodeData.results[0].earningsPerShare ?? 0.0)
            return currentState
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

//MARK: - String

extension String {
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }

    func removeWhitespace() -> String {
        return self.replace(string: " ", replacement: "")
    }
}
