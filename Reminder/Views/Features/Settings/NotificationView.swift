import SwiftUI

struct NotificationView: View {
    let appUser: AppUser
    @State private var userName: UserNameViewModel
    
    init(appUser: AppUser) {
        self.appUser = appUser
        _userName = State(wrappedValue: UserNameViewModel(userID: appUser.uid))
    }
    
    var body: some View {
        VStack {
            Button {
                NotificationManager.shared.requestAuthorization { success, error in
                    if success {
                        print("All set")
                    } else if let error {
                        print(error.localizedDescription)
                    }
                }
            } label: {
                Text("Request Permission")
            }
            
            Button {
                NotificationManager.shared.scheduleNotification(
                    title: "Xin chào \(userName.name)",
                    subtitle: "Đây là thông báo ảo",
                    timeInterval: 5
                )
            } label: {
                Text("Schedule Notification")
            }
        }
    }
}

#Preview {
    NotificationView(appUser: .init(uid: "2311", email: ""))
}
