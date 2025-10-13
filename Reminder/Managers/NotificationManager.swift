import SwiftUI
import UserNotifications

struct NotificationManager: View {
    let appUser: AppUser
    @State private var userName: UserNameViewModel

    init(appUser: AppUser) {
        self.appUser = appUser
        _userName = State(wrappedValue: UserNameViewModel(userID: appUser.uid))
    }

    var body: some View {
        VStack{
            Button {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
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
                let content = UNMutableNotificationContent()
                content.title = "Xin chào \(userName.name)"
                content.subtitle = "Đây là thông báo ảo"
                content.sound = UNNotificationSound.default
                
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                UNUserNotificationCenter.current().add(request)
            } label: {
                Text("Schedule Notification")
            }
        }
    }
}
