
import Foundation
import UIKit

final class LoginViewModel: LoginViewModelProtocol {
    
    var user = User()
    
    
    func isAuth(login: String, password: String, completion: @escaping (Bool) -> ()) {
        if login == user.login && password == user.password {
            completion(true)
        } else {
            completion(false)
        }
    }
    
    func showTableVC() {
        let vc = TableViewController()
        let nav = UINavigationController(rootViewController: vc)
        UIApplication.shared.windows.first?.rootViewController = nav
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        vc.modalTransitionStyle = .flipHorizontal
        Defaults.shared.isAuth(auth: true)
    }
}
