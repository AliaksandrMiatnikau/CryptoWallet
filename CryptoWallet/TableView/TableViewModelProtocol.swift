
import Foundation
import UIKit

protocol TableViewModelProtocol {
    
    var symbolCrypto: String        { get }
    var costCrypto: Double          { get }
    
    func numberOfRows() -> Int
    func getCrypto(completion: @escaping (_ crypto: Coin) -> ())
    func viewModelForSelectedRow(for indexPath: IndexPath) -> DetailedViewModelProtocol?
    func filtredData()
    func crypto(at index: Int) -> Coin
}
