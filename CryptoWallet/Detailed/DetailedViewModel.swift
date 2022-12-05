

import Foundation

final class DetailedViewModel: DetailedViewModelProtocol {
    
    private var crypto: Coin?
    
    var nameCrypto: String {
        guard let name = crypto?.data.name else { return "" }
        return name
    }
    
    var costCrypto: Double {
        guard let cost = crypto?.data.marketData.priceUSD else { return 0 }
        return cost
    }
    
    var symbolCrypto: String {
        guard let symbol = crypto?.data.symbol else { return "" }
        return symbol
    }
    
    var priceYesterday: Double {
        guard let percent24Hours = crypto?.data.marketData.dayPercentageChange else { return 0 }
        guard let todayPrice = crypto?.data.marketData.priceUSD else { return 0 }
        return todayPrice - ((todayPrice / 100) * percent24Hours)
    }
    
    var changingPersent: Double {
        guard let symbol = crypto?.data.marketData.dayPercentageChange else { return 0 }
        return symbol
    }
    
    init(crypto: Coin?) {
        self.crypto = crypto
    }
}
