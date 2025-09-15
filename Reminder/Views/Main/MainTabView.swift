import SwiftUI

struct MainTabView: View {
    var appUser: AppUser
    let onSignOut: () -> Void
    
    var body: some View {
        TabView{
            Tab("home_page_text", systemImage: "house.fill") {
                    MainView(appUser: appUser)
            }
            
            Tab("event_text", systemImage: "calendar.badge.plus"){
                Text("add_event")
            }
            
            Tab("setting_text", systemImage: "gearshape.fill") {
                SettingView (appUser: appUser, onSignOut: {
                        onSignOut()
                })
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
