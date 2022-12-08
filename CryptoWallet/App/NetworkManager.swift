
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
            group.enter()
            guard let url = URL(string: "https://data.messari.io/api/v1/assets/\(i)/metrics") else { return }
            URLSession.shared.dataTask(with: url) { (data, response, error) in
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
