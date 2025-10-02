import SwiftUI

@Observable
class UserNameViewModel{
    var name: String = UserDefaults.standard.string(forKey: "username") ?? "Người dùng"
}
