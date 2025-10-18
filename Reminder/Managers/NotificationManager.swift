import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    func requestAuthorization(completion: @escaping (Bool, Error?) -> Void) {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { success, error in
            completion(success, error)
        }
    }
    
    func scheduleNotification(title: String, subtitle: String, timeInterval: TimeInterval, selectedSound: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        
        if selectedSound == "default" {
            content.sound = .default
        } else {
            let soundFileName = "\(selectedSound).caf"
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: soundFileName))
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(
            timeInterval: timeInterval,
            repeats: false
        )
        
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func scheduleDailyNotification(title: String, subtitle: String, selectedSound: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.subtitle = subtitle
        
        if selectedSound == "default" {
            content.sound = .default
        } else {
            let soundFileName = "\(selectedSound).caf"
            content.sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: soundFileName))
        }
        
        var dateComponents = DateComponents()
        dateComponents.hour = 7
        dateComponents.minute = 0
        
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: dateComponents,
            repeats: true
        )
        
        let request = UNNotificationRequest(
            identifier: "dailyMorningNotification",
            content: content,
            trigger: trigger
        )
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func cancelDailyNotification() {
        UNUserNotificationCenter.current().removePendingNotificationRequests(
            withIdentifiers: ["dailyMorningNotification"]
        )
    }
}
