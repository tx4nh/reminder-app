import SwiftUI

struct MainTabView: View {
    var appUser: AppUser
    let onSignOut: () -> Void
    
    var body: some View {
        TabView{
            Tab("Main View", systemImage: "house.fill") {
                    MainView(appUser: appUser, onSignOut: {
                        Task{
                            try await supabase.auth.signOut()
//                            appUser = nil
                        }
                    })
            }
            
            Tab("Ca Nhan", systemImage: "person.fill") {
                Text("Ca nhan day")
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#Preview {
    MainTabView(appUser: AppUser(uid: "2311", email: "atdevv@gmail.com"), onSignOut: {
        print("Sign Out")
    })
}
    
