import SwiftUI

struct MainTabView: View {
    var appUser: AppUser
    let onSignOut: () -> Void
    
    var body: some View {
        TabView{
            Tab("Main View", systemImage: "house.fill") {
                    MainView(appUser: appUser)
            }
            
            Tab("Cài Đặt", systemImage: "gearshape.fill") {
                SettingView {
                        onSignOut()
                }
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
