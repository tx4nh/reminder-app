import SwiftUI

struct ReminderAppView: View {
    @State private var appUser: AppUser? = nil
    @State private var isLoading: Bool = true

    var body: some View {
        VStack {
            if isLoading {
                LoadingView()
            } else {
                if let user = appUser {
                    MainTabView(appUser: user, onSignOut: {
                        Task{
                            try await supabase.auth.signOut()
                            appUser = nil
                            isLoading = false
                        }
                    })
                } else {
                    SignInView(appUser: $appUser)
                }
            }
        }
        .animation(.easeInOut(duration: 0.3), value: appUser != nil)
        .onAppear {
            checkSession()
            PermissionManager.shared.setupPermissions()
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
                isLoading = false
            } catch{
                print("No User")
                isLoading = false
            }
        }
    }
}

#Preview {
    ReminderAppView()
}
