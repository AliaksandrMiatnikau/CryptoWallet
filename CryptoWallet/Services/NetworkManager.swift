
import Foundation

final class NetworkManager {
    
    static let shared = NetworkManager()
    let group = DispatchGroup()
    
    enum CoinNames: String, CaseIterable {
        case btc = "btc"
        case ltc = "ltc"
        case etc = "etc"
        case tron = "tron"
        case luna = "luna"
        case polkadot = "polkadot"
        case dogecoin = "dogecoin"
        case stellar = "stellar"
        case cardano = "cardano"
        case xrp = "xrp"
        case bnb = "bnb"
        case busd = "busd"
        case usdt = "usdt"
        case matic = "matic"
        
        var url: String {
            return "https://data.messari.io/api/v1/assets/\(self.rawValue)/metrics"
        }
    }
    
    public func fetchData(completion: @escaping (_ crypto: Coin) -> ()) {
        for i in CoinNames.allCases {
            group.enter()
            guard let url = URL(string: i.url) else { return }
            URLSession.shared.dataTask(with: url) { (data, _, error) in
                guard let data = data, error == nil  else { return }
                do {
                    let result = try? JSONDecoder().decode(Coin.self, from: data)
                    self.group.leave()
                    guard let mainData = result else { return }
                    self.group.notify(queue: .main) {
                        completion(mainData)
                    }
                } catch let error {
                    print("Error serialization JSON", error.localizedDescription)
                }
            }.resume()
        }
    }
}

