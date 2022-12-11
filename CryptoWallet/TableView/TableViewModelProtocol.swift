
import Foundation
import UIKit

protocol TableViewModelProtocol {
    
    func numberOfRows() -> Int
    func getCrypto(completion: @escaping (_ crypto: Coin?) -> ())
    func viewModelForSelectedRow(for indexPath: IndexPath) -> DetailedViewModelProtocol?
    func sortData()
    func cryptoArrayData(at index: Int) -> Coin
}
