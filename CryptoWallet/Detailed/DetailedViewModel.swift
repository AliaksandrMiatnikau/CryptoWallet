

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
    
    var percentChangeUsdLast24Hours: Double {
        guard let price24Hours = crypto?.data.marketData.dayPercentageChange else { return 0 }
        guard let cost = crypto?.data.marketData.priceUSD else { return 0 }
        return ((cost / 100) * price24Hours) + cost
    }
    
    init(crypto: Coin?) {
        self.crypto = crypto
    }
}
