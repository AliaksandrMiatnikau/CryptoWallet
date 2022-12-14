

import Foundation
import UIKit

final class TableViewModel: TableViewModelProtocol {
    
    
    private var networkManager = NetworkManager()
    var crypto: Coin?
    var sortingFlag = true
    var dataSource: [Coin] = []
    
    
    
    func numberOfRows() -> Int {
        return dataSource.count
    }
    
    func getCrypto(completion: @escaping (Coin?) -> ()) {
        networkManager.fetchData() { [weak self] crypto in
                guard let self = self else { return }
                self.crypto = crypto
                self.dataSource.append(crypto)
                self.dataSource.sort{$0.data.marketData.priceUSD > $1.data.marketData.priceUSD}
                completion(crypto)
        }
    }
    
    func cryptoArrayData(at index: Int) -> Coin {
        return dataSource[index]
    }
    
    func viewModelForSelectedRow(for indexPath: IndexPath) -> DetailedViewModelProtocol? {
        let crypto = dataSource[indexPath.row]
        return DetailedViewModel(crypto: crypto)
    }
    
    func sortData() {
        sortingFlag = !sortingFlag
        if sortingFlag {
            dataSource.sort{ $0.data.marketData.dayPercentageChange ?? 0 < $1.data.marketData.dayPercentageChange ?? 0 }
        } else {
            dataSource.sort{ $0.data.marketData.dayPercentageChange ?? 0 > $1.data.marketData.dayPercentageChange ?? 0 }
        }
    }
}
