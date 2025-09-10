import SwiftUI

struct SettingView: View {
    let onSignOut: () -> Void
    @State private var showChangePassword = false
    @State private var showNotificationSettings = false
    @State private var showProfileSettings = false
    @State private var showLanguageSettings = false
    @State private var showAbout = false
    @State private var darkModeEnabled = false
    @State private var autoBackupEnabled = true
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Spacer()
                        VStack(alignment: .center, spacing: 12) {
                            ZStack {
                                Circle()
                                    .fill(Color.accentColor.opacity(0.1))
                                    .frame(width: 90, height: 90)
                                
                                Image(systemName: "person.circle.fill")
                                    .font(.system(size: 60))
                                    .foregroundColor(.accentColor)
                            }
                        
                            VStack(spacing: 4) {
                                Text("Xin chào!")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.primary)
                            }
                        }
                        Spacer()
                    }
                    .padding(.vertical, 20)
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
                
                Section {
                    SettingRowView(
                        icon: "person.crop.circle",
                        title: "Thông tin cá nhân",
                        subtitle: "Cập nhật hồ sơ và thông tin",
                        iconColor: .blue
                    ) {
                        showProfileSettings = true
                    }
                
                    SettingRowView(
                        icon: "key",
                        title: "Đổi mật khẩu",
                        subtitle: "Cập nhật mật khẩu bảo mật",
                        iconColor: .green
                    ) {
                        showChangePassword = true
                    }
                } header: {
                    Text("Tài khoản")
                }
                
                Section {
                    SettingRowView(
                        icon: "bell",
                        title: "Cài đặt thông báo",
                        subtitle: "Âm thanh, rung và nhắc nhở",
                        iconColor: .orange
                    ) {
                        showNotificationSettings = true
                    }
                } header: {
                    Text("Thông báo")
                }
                
                Section {
                    ToggleRowView(
                        icon: "moon.fill",
                        title: "Chế độ tối",
                        subtitle: "Giao diện tối cho mắt",
                        iconColor: .indigo,
                        isOn: $darkModeEnabled
                    )
                    
                    SettingRowView(
                        icon: "globe",
                        title: "Ngôn ngữ",
                        subtitle: "Thay đổi ngôn ngữ ứng dụng",
                        iconColor: .purple,
                    ) {
                        showLanguageSettings = true
                    }
                    
                    ToggleRowView(
                        icon: "icloud.and.arrow.up",
                        title: "Sao lưu tự động",
                        subtitle: "Tự động sao lưu dữ liệu",
                        iconColor: .cyan,
                        isOn: $autoBackupEnabled
                    )
                } header: {
                    Text("Ứng dụng")
                }
                
                Section {
                    SettingRowView(
                        icon: "questionmark.circle",
                        title: "Trợ giúp",
                        subtitle: "Câu hỏi thường gặp và hướng dẫn",
                        iconColor: .teal
                    ) {
                        // TODO: Show help view
                        print("Help tapped")
                    }
                    
                    SettingRowView(
                        icon: "info.circle",
                        title: "Về ứng dụng",
                        subtitle: "Phiên bản và thông tin",
                        iconColor: .gray
                    ) {
                        showAbout = true
                    }
                    
                    SettingRowView(
                        icon: "star",
                        title: "Đánh giá ứng dụng",
                        subtitle: "Chia sẻ trải nghiệm của bạn",
                        iconColor: .yellow
                    ) {
                        // TODO: Open App Store rating
                        print("Rate app tapped")
                    }
                } header: {
                    Text("Hỗ trợ")
                }
                
                VStack(spacing: 16) {
                    Button(action: {
                        onSignOut()
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .font(.system(size: 16, weight: .medium))
                            Text("Đăng xuất")
                                .font(.system(size: 16, weight: .medium))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.red)
                            .shadow(color: Color.red.opacity(0.3), radius: 4, x: 0, y: 2)
                    )
                    .foregroundColor(.white)
                }
                .listRowInsets(EdgeInsets())
                .listRowBackground(Color.clear)
            }
            .navigationTitle("Cài đặt")
            .navigationBarTitleDisplayMode(.automatic)
        }
        .sheet(isPresented: $showChangePassword) {
            ChangePasswordView()
        }
        .sheet(isPresented: $showNotificationSettings) {
            NotificationSettingsView()
        }
        .sheet(isPresented: $showProfileSettings) {
            ProfileSettingsView()
        }
        .sheet(isPresented: $showAbout) {
            AboutView()
        }
    }
}

#Preview {
    SettingView(onSignOut: {
        print("Sign Out")
    })
}
