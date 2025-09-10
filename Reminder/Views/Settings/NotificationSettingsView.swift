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
    
    let soundOptions = ["Mặc định", "Chuông", "Báo thức", "Nhẹ nhàng", "Sôi động", "Tắt"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Header
                    VStack(spacing: 8) {
                        Image(systemName: "bell.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.orange)
                        
                        Text("Cài đặt thông báo")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Tùy chỉnh cách bạn nhận thông báo")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 20)
                    
                    // General Notifications
                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: "Thông báo chung")
                        
                        VStack(spacing: 8) {
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
                            
                            ToggleRowView(
                                icon: "app.badge",
                                title: "Hiển thị số",
                                subtitle: "Hiển thị số thông báo trên icon app",
                                iconColor: .green,
                                isOn: $badgeEnabled
                            )
                        }
                    }
                    
                    // Sound Settings
                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: "Âm thanh")
                        
                        PickerRowView(
                            icon: "speaker.wave.3",
                            title: "Âm thanh thông báo",
                            subtitle: "Chọn âm thanh cho thông báo",
                            iconColor: .orange,
                            currentValue: selectedSound
                        ) {
                            showSoundPicker = true
                        }
                    }
                    
                    // Reminder Timing
                    VStack(alignment: .leading, spacing: 12) {
                        SectionHeader(title: "Thời gian nhắc nhở")
                        
                        VStack(spacing: 8) {
                            ToggleRowView(
                                icon: "clock",
                                title: "15 phút trước",
                                subtitle: "Nhắc nhở 15 phút trước sự kiện",
                                iconColor: .cyan,
                                isOn: $reminderBefore15Min
                            )
                            
                            ToggleRowView(
                                icon: "clock",
                                title: "1 giờ trước",
                                subtitle: "Nhắc nhở 1 giờ trước sự kiện",
                                iconColor: .indigo,
                                isOn: $reminderBefore1Hour
                            )
                            
                            ToggleRowView(
                                icon: "clock",
                                title: "1 ngày trước",
                                subtitle: "Nhắc nhở 1 ngày trước sự kiện",
                                iconColor: .pink,
                                isOn: $reminderBefore1Day
                            )
                        }
                    }
                    
                    // Test Notification Button
                    Button(action: testNotification) {
                        HStack(spacing: 8) {
                            Image(systemName: "bell.and.waves.left.and.right")
                                .font(.system(size: 16, weight: .medium))
                            Text("Thử thông báo")
                                .font(.system(size: 16, weight: .medium))
                        }
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
                    
                    Spacer(minLength: 20)
                }
                .padding(.horizontal, 20)
            }
            .navigationTitle("Thông báo")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Quay lại") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Lưu") {
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
        // TODO: Implement test notification
        print("Test notification triggered")
    }
    
    private func saveSettings() {
        // TODO: Save notification settings to Supabase
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
            .navigationTitle("Âm thanh")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Hủy") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Chọn") {
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