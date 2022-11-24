

import Foundation
import UIKit

final class TableViewModel: TableViewModelProtocol {
    
    func numberOfRows() -> Int {
        return dataaa.count
    }
    
    private var networkManager = NetworkManager()
    var crypto: Coin?
    var cryptoData: CoinData?
    private var isSelect = false
    private var filteredData: [Coin] = []
    var dataaa: [Coin] = []
    let group = DispatchGroup()
    
    var symbolCrypto: String {
        guard let name = crypto?.data.name else { return "" }
        return name
    }
    
    var costCrypto: Double {
        guard let priceUsd = crypto?.data.marketData.priceUSD  else  { return 0 }
        return priceUsd
    }
    
    func getCrypto(completion: @escaping (Coin) -> ()) {
        for i in NetworkManager.shared.urls {
            group.enter()
            networkManager.fetchData(url: i) { [weak self] crypto in
                DispatchQueue.main.async {
                    
                    guard let self = self else { return }
                    //                    self.crypto = crypto
                    self.dataaa.append(crypto)
                    completion(crypto)
                    print(crypto.data)
                }
            }
            self.group.leave()
        }
        group.notify(queue: .main) {
            
            print("done")
        }
    }
    
    
    
    func crypto(at index: Int) -> Coin {
        return dataaa[index]
    }
    
    
    
    //    func getCrypto(completion: @escaping (Coin) -> ()) {
    //        networkManager.fetchData { [weak self] crypto in
    //            DispatchQueue.main.async {
    //                guard let self = self else {return}
    //                self.crypto = crypto
    //
    //                completion(crypto)
    //                print(crypto.data)
    //
    //            }
    //        }
    //    }
    
    func viewModelForSelectedRow(for indexPath: IndexPath) -> DetailedViewModelProtocol? {
        let data = dataaa.sorted(by: { $0.data.marketData.priceUSD  > $1.data.marketData.priceUSD  } )
        let crypto = isSelect ? filteredData[indexPath.row] : data[indexPath.row]
        
        return DetailedViewModel(crypto: crypto)
    }
    
    
    
    
    
    func filtredData() {
        isSelect = !isSelect
        guard let data = crypto?.data else { return }
        if isSelect {
            filteredData = dataaa.sorted(by: { $0.data.marketData.dayPercentageChange ?? 0 < $1.data.marketData.dayPercentageChange ?? 0 } )
        }
    }
    
    //    init(crypto: Coin, cryptoData: CoinData) {
    //        self.crypto = crypto
    //        self.cryptoData = cryptoData
    //    }
}
