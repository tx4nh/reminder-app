import SwiftUI

@Observable
class UserNameViewModel {
    private let userID: String
    private var userDefaultsKey: String {
        "username\(userID)"
    }
    
    var name: String {
        didSet {
            UserDefaults.standard.set(name, forKey: userDefaultsKey)
        }
    }
    
    init(userID: String) {
        self.userID = userID
        let key = "username\(userID)"
        self.name = UserDefaults.standard.string(forKey: key) ?? "Người dùng"
    }
}
