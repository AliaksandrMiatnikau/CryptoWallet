
import Foundation



final class NetworkManager {
    
    static let shared = NetworkManager()
    let group = DispatchGroup()
    
    let urls = [
        "https://data.messari.io/api/v1/assets/btc/metrics",
        "https://data.messari.io/api/v1/assets/ltc/metrics",
        "https://data.messari.io/api/v1/assets/tron/metrics",
        "https://data.messari.io/api/v1/assets/luna/metrics",
        "https://data.messari.io/api/v1/assets/polkadot/metrics",
        "https://data.messari.io/api/v1/assets/dogecoin/metrics",
        "https://data.messari.io/api/v1/assets/tether/metrics",
        "https://data.messari.io/api/v1/assets/stellar/metrics",
        "https://data.messari.io/api/v1/assets/cardano/metrics",
        "https://data.messari.io/api/v1/assets/xrp/metrics"
    ]
    
    public func fetchData(url: String, completion: @escaping (_ crypto: Coin) -> ()) {
        
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil  else { return }
            
            do {
                var result: Coin?
                result = try? JSONDecoder().decode(Coin.self, from: data)
                guard let mainData = result else { return }
                completion(mainData)
                print(mainData.data.marketData.priceUSD)
                print(mainData.data.marketData.dayPercentageChange ?? 0)
            } catch let error {
                print("Error serialization JSON", error.localizedDescription)
            }
        }.resume()
    }
}
