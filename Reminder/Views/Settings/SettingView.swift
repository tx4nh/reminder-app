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
        NavigationStack {
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
                                Text("hello_text")
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
                    NavigationLink {
                        ProfileSettingsView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        SettingRowView(
                            icon: "person.crop.circle",
                            title: "Thông tin cá nhân",
                            subtitle: "Cập nhật hồ sơ và thông tin",
                            iconColor: .blue
                        )
                    }

                    NavigationLink {
                        ChangePasswordView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        SettingRowView(
                            icon: "key",
                            title: "Đổi mật khẩu",
                            subtitle: "Cập nhật mật khẩu bảo mật",
                            iconColor: .green
                        )
                    }
                } header: {
                    Text("account_text")
                }
                
                Section {
                    NavigationLink{
                        NotificationSettingsView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        SettingRowView(
                            icon: "bell",
                            title: "Cài đặt thông báo",
                            subtitle: "Âm thanh, rung và nhắc nhở",
                            iconColor: .orange
                        )
                    }
                } header: {
                    Text("notification_text")
                }
                
                Section {
                    ToggleRowView(
                        icon: "moon.fill",
                        title: "Chế độ tối",
                        subtitle: "Giao diện tối cho mắt",
                        iconColor: .indigo,
                        isOn: $darkModeEnabled
                    )

                    NavigationLink{
//                        LanguageSettingView()
                    } label: {
                        SettingRowView(
                            icon: "globe",
                            title: "Ngôn ngữ",
                            subtitle: "Thay đổi ngôn ngữ ứng dụng",
                            iconColor: .purple,
                        )
                    }

                    ToggleRowView(
                        icon: "icloud.and.arrow.up",
                        title: "Sao lưu tự động",
                        subtitle: "Tự động sao lưu dữ liệu",
                        iconColor: .cyan,
                        isOn: $autoBackupEnabled
                    )
                } header: {
                    Text("app_text")
                }
                
                Section {
                    NavigationLink{
                        
                    } label: {
                        SettingRowView(
                            icon: "questionmark.circle",
                            title: "Trợ giúp",
                            subtitle: "Câu hỏi thường gặp và hướng dẫn",
                            iconColor: .teal
                        )
                    }

                    NavigationLink{
                        AboutView()
                            .navigationBarBackButtonHidden()
                    } label: {
                        SettingRowView(
                            icon: "info.circle",
                            title: "Về ứng dụng",
                            subtitle: "Phiên bản và thông tin",
                            iconColor: .gray
                        )
                    }
                    
                    NavigationLink{
                        
                    } label: {
                        SettingRowView(
                            icon: "star",
                            title: "Đánh giá ứng dụng",
                            subtitle: "Chia sẻ trải nghiệm của bạn",
                            iconColor: .yellow
                        )
                    }
                } header: {
                    Text("support_text")
                }
                
                VStack(spacing: 16) {
                    Button(action: {
                        onSignOut()
                    }) {
                        HStack(spacing: 8) {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                                .font(.system(size: 16, weight: .medium))
                            Text("sign_out_text")
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
            .navigationTitle("setting_text")
            .navigationBarTitleDisplayMode(.automatic)
        }
    }
}

#Preview {
    SettingView(onSignOut: {
        print("Sign Out")
    })
}
