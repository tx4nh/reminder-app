import AVFoundation
import UserNotifications

class PermissionManager {
    static let shared = PermissionManager()
    
    private init() {}
    
    func setupPermissions() {
        setupAudio()
        requestNotificationIfNeeded()
    }
    
    private func setupAudio() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playback, mode: .default, options: [.mixWithOthers])
            try audioSession.setActive(true)
            print("Audio ready")
        } catch {
            print("Audio error: \(error)")
        }
    }
    
    private func requestNotificationIfNeeded() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .notDetermined {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
                    print(granted ? "Notification granted" : "Notification denied")
                }
            } else {
                print("Notification already set: \(settings.authorizationStatus.rawValue)")
            }
        }
    }
}
