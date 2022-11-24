
import Foundation

protocol DetailedViewModelProtocol {
    
    var nameCrypto: String                      { get }
    var costCrypto: Double                      { get }
    var symbolCrypto: String                    { get }
    var percentChangeUsdLast24Hours: Double     { get }
    
    
}
