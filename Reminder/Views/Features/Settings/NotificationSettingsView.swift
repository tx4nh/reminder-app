import SwiftUI

struct NotificationSettingsView: View {
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
    
    @State private var activeTimePicker: EventType?
    @State private var isPressed = false
    
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

    private func saveSettings() {
        print("Saving notification settings...")
        print("Daily: \(dailyEventTime), Weekly: \(weeklyEventTime), Yearly: \(yearlyEventTime)")
        dismiss()
    }
}

#Preview {
    NotificationSettingsView()
}
