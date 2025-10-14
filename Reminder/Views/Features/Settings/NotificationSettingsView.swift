import SwiftUI

struct NotificationSettingsView: View {
    let appUser: AppUser
    @Environment(\.dismiss) private var dismiss
    @State private var pushNotificationsEnabled = true
    @State private var soundEnabled = true
    @State private var vibrationEnabled = true
    @State private var badgeEnabled = true
    @State private var selectedSound = "Mặc định"

    @State private var dailyEventTime = "1 giờ"
    @State private var weeklyEventTime = "1 ngày"
    @State private var yearlyEventTime = "1 ngày"
    
    @State private var showSoundPicker = false
    
    @State private var userName: UserNameViewModel
    @State private var activeTimePicker: EventType?
    @State private var isPressed = false
    @State private var showAlert = false
    
    init(appUser: AppUser) {
        self.appUser = appUser
        _userName = State(wrappedValue: UserNameViewModel(userID: appUser.uid))
    }
    
    enum EventType: Identifiable {
        case daily, weekly, yearly
        var id: Self { self }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    ToggleRowView(
                        icon: "bell.badge",
                        title: "Thông báo đẩy",
                        subtitle: "Nhận thông báo khi có lịch hẹn",
                        iconColor: .red,
                        isOn: $pushNotificationsEnabled
                    )
                    
                    ToggleRowView(
                        icon: "speaker.wave.2",
                        title: "Âm thanh",
                        subtitle: "Phát âm thanh khi có thông báo",
                        iconColor: .blue,
                        isOn: $soundEnabled
                    )
                    
                    ToggleRowView(
                        icon: "iphone.radiowaves.left.and.right",
                        title: "Rung",
                        subtitle: "Rung khi có thông báo",
                        iconColor: .purple,
                        isOn: $vibrationEnabled
                    )
                } header: {
                    Text("general_text")
                }
                
                Section {
                    PickerRowView(
                        icon: "speaker.wave.3",
                        title: "Âm thanh thông báo",
                        subtitle: "Chọn âm thanh cho thông báo",
                        iconColor: .orange,
                        currentValue: selectedSound
                    ) {
                        showSoundPicker = true
                    }
                } header: {
                    Text("notification_text")
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                
                Section {
                    TimeNotification(eventName: "Sự kiện ngày", selectedTime:$dailyEventTime) {
                        activeTimePicker = .daily
                    }
                    TimeNotification(eventName: "Sự kiện tuần", selectedTime: $weeklyEventTime) {
                        activeTimePicker = .weekly
                    }
                    TimeNotification(eventName: "Sự kiện năm", selectedTime: $yearlyEventTime) {
                        activeTimePicker = .yearly
                    }
                } header: {
                    Text("reminder_time")
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 16))
                
                VStack {
                    Button {
                        showAlert.toggle()
                        isPressed.toggle()
//                        testNotification()
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "bell.and.waves.left.and.right")
                                .font(.system(size: 16, weight: .medium))
                            Text("test_notice")
                                .font(.system(size: 16, weight: .medium))
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 44)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.accentColor.opacity(0.1))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.accentColor, lineWidth: 1)
                                )
                        )
                        .foregroundColor(.accentColor)
                        .scaleEffect(isPressed ? 0.95 : 1.0)
                        .opacity(isPressed ? 0.8 : 1.0)
                        .animation(.easeInOut(duration: 0.1), value: isPressed)
                    }
                }
                .listRowInsets(EdgeInsets())
            }
            .navigationTitle("notification_text")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("comeback_text") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("save_text") {
                        saveSettings()
                    }
                    .fontWeight(.semibold)
                }
            }
            .alert("notification_text", isPresented: $showAlert) {
                Button("OK") {
                    testNotification()
                    }
                } message: {
                    Text("a_test_notification_will_be_sent_in_5_seconds.\nPlease_return_to your_phone's_home_screen.")
                }
        }
        .sheet(isPresented: $showSoundPicker) {
            SoundPickerView(selectedSound: $selectedSound)
        }
        .sheet(item: $activeTimePicker) { eventType in
            switch eventType {
            case .daily:
                TimePickerView(selectedTime: $dailyEventTime)
            case .weekly:
                TimePickerView(selectedTime: $weeklyEventTime)
            case .yearly:
                TimePickerView(selectedTime: $yearlyEventTime)
            }
        }
    }
    
    private func testNotification() {
        NotificationManager.shared.scheduleNotification(
            title: "Xin chào \(userName.name)",
            subtitle: "Đây là thông báo ảo",
            timeInterval: 5
        )
    }

    private func saveSettings() {
        print("Saving notification settings...")
        print("Daily: \(dailyEventTime), Weekly: \(weeklyEventTime), Yearly: \(yearlyEventTime)")
        dismiss()
    }
}

#Preview {
    NotificationSettingsView(appUser: .init(uid: "2311", email: ""))
}
