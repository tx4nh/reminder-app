import SwiftUI

struct ContentView: View {
    @State private var appUser: AppUser? = nil
    @State private var isLoading: Bool = false
    
    var body: some View {
        VStack {
            if let user = appUser {
                MainView(appUser: user, onSignOut: {
                    Task{
                        try await supabase.auth.signOut()
                        appUser = nil
                    }
                })
            } else {
                SignInView(appUser: $appUser)
            }
        }
        .animation(.easeInOut(duration: 0.3), value: appUser != nil)
        .onAppear {
            checkSession()
        }
    }
    
    private func checkSession(){
        Task{
            do{
                let session = try await supabase.auth.session
                
                let user = AppUser(
                    uid: session.user.id.uuidString,
                    email: session.user.email ?? ""
                )
                
                self.appUser = user
            } catch{
                print("Error kaka")
            }
        }
    }
}

#Preview {
    ContentView()
}
