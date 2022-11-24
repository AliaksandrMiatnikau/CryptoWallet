
import Foundation

protocol LoginViewModelProtocol {
    
    func isAuth(login: String, password: String, completion: @escaping (Bool) -> ())
    func showTableVC()
}
