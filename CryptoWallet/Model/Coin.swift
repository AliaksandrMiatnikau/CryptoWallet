

import Foundation


struct Coin: Decodable {
    let data: CoinData
}

struct CoinData: Decodable {
    let name: String
    let symbol: String
    let marketData: CoinMarketData
    
    enum CodingKeys: String, CodingKey {
        case name
        case symbol
        case marketData = "market_data"
    }
}

struct CoinMarketData: Decodable {
    let priceUSD: Double
    let priceBTC: Double
    let hourPercentageChange: Double?
    let dayPercentageChange: Double?
    
    enum CodingKeys: String, CodingKey {
        case priceUSD = "price_usd"
        case priceBTC = "price_btc"
        case hourPercentageChange = "percent_change_usd_last_1_hour"
        case dayPercentageChange = "percent_change_usd_last_24_hours"
    }
}
