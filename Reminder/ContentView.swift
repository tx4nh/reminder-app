import SwiftUI

struct ContentView: View {
    @State private var appUser: AppUser? = nil
    
    var body: some View {
        VStack {
            if let user = appUser {
                MainView(appUser: user, onSignOut: {
                    appUser = nil
                })
            } else {
                SignInView(appUser: $appUser)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: appUser != nil)
    }
}

#Preview {
    ContentView()
}
