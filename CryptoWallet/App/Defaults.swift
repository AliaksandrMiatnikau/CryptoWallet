
import Foundation

class Defaults {
    
    static let shared = Defaults()
    
    private let defaultKey = "authorization"
    private let defaults = UserDefaults.standard
    
    func isAuth(auth: Bool) {
        defaults.set(auth, forKey: defaultKey)
    }
    
    func getAuth() -> Bool {
        return (defaults.value(forKey: defaultKey) as? Bool ?? false )
    }
    
    func clear() {
        defaults.removeObject(forKey: defaultKey)
    }
}
