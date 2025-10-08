import SwiftUI

struct NotificationSettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var pushNotificationsEnabled = true
    @State private var soundEnabled = true
    @State private var vibrationEnabled = true
    @State private var badgeEnabled = true
    @State private var reminderBefore15Min = true
    @State private var reminderBefore1Hour = false
    @State private var reminderBefore1Day = false
    @State private var selectedSound = "Mặc định"
    @State private var showSoundPicker = false
    @State private var isPressed = false
    
    let soundOptions = ["Mặc định", "Chuông", "Báo thức", "Nhẹ nhàng", "Sôi động", "Tắt"]
    
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
                    Text("Thông báo chung")
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
                
                Section{
                    TimeNotification(eventName: "Sự kiện ngày", eventTime: "1 giờ")
                    TimeNotification(eventName: "Sự kiện tuần", eventTime: "1 ngày")
                    TimeNotification(eventName: "Sự kiện năm", eventTime: "1 ngày")
                } header: {
                    Text("Thời gian nhắc nhở")
                }
                
                VStack{
                    Button {
                        isPressed.toggle()
                        testNotification()
                    } label: {
                        HStack(spacing: 8) {
                            Image(systemName: "bell.and.waves.left.and.right")
                                .font(.system(size: 16, weight: .medium))
                            Text("Thử thông báo")
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
                .listRowBackground(Color.clear)
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
    }
    
    private func testNotification() {
        print("Test notification triggered")
    }
    
    private func saveSettings() {
        print("Saving notification settings...")
        dismiss()
    }
}

struct SectionHeader: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.system(size: 18, weight: .semibold))
            .foregroundColor(.primary)
            .padding(.horizontal, 4)
    }
}

struct SoundPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedSound: String
    @State private var tempSelection: String
    
    let soundOptions = ["Mặc định", "Chuông", "Báo thức", "Nhẹ nhàng", "Sôi động", "Tắt"]
    
    init(selectedSound: Binding<String>) {
        self._selectedSound = selectedSound
        self._tempSelection = State(initialValue: selectedSound.wrappedValue)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(soundOptions, id: \.self) { sound in
                    HStack {
                        Text(sound)
                            .font(.system(size: 16))
                        
                        Spacer()
                        
                        if tempSelection == sound {
                            Image(systemName: "checkmark")
                                .foregroundColor(.accentColor)
                                .font(.system(size: 16, weight: .semibold))
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        tempSelection = sound
                    }
                }
            }
            .navigationTitle("sound_text")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("cancel_text") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("select_text") {
                        selectedSound = tempSelection
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    NotificationSettingsView()
}
