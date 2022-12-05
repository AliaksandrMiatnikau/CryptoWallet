
import Foundation



final class NetworkManager {
    
    static let shared = NetworkManager()
    let group = DispatchGroup()
    
    enum CoinNames {
        static let symbols: [String] = [
            "btc", "ltc", "etc", "tron", "luna", "polkadot", "dogecoin", "stellar", "cardano", "xrp", "bnb", "busd", "usdt"
        ]
    }
    
    public func fetchData(completion: @escaping (_ crypto: Coin) -> ()) {
        for i in CoinNames.symbols {
            guard let url = URL(string: "https://data.messari.io/api/v1/assets/\(i)/metrics") else { return }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                guard let data = data, error == nil  else { return }
                
                do {
                    let result = try? JSONDecoder().decode(Coin.self, from: data)
                    guard let mainData = result else { return }
                    completion(mainData)
                    print(mainData.data.marketData.priceUSD)
                } catch let error {
                    print("Error serialization JSON", error.localizedDescription)
                }
            }.resume()
        }
    }
}
