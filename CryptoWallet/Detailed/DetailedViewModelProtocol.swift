
import Foundation

protocol DetailedViewModelProtocol {
    
    var nameCrypto: String                      { get }
    var costCrypto: Double                      { get }
    var symbolCrypto: String                    { get }
    var priceYesterday: Double                  { get }
    var changingPersent: Double                 { get }
    
    
}
