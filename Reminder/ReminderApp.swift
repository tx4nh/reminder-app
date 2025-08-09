import SwiftUI

@main
struct ReminderApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
            SignInView(email: "", password: "", appUser: .constant(AppUser(uid: "", email: "")))
        }
    }
}
