import SwiftUI

struct SettingView: View {
    let appUser: AppUser
    let onSignOut: () -> Void
    @Environment(ThemeViewModel.self) private var themeViewModel
    @Environment(AppLanguageManager.self) private var appLanguage
    @Environment(UserNameViewModel.self) private var userName
    @State private var showSignOutAlert: Bool = false
    @State private var isLoading: Bool = false

    var body: some View {
        @Bindable var themeViewModel = themeViewModel
        if isLoading {
            LoadingView()
        } else {
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
                                
                                HStack(spacing: 4) {
                                    Text("hello_text")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .foregroundColor(.primary)
                                    Text(userName.name)
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
                            ProfileSettingsView(appUser: appUser, userName: userName)
                                .navigationBarBackButtonHidden()
                        } label: {
                            SettingRowView(
                                icon: "person.crop.circle",
                                title: "personal_information",
                                subtitle: "update_profile",
                                iconColor: .blue
                            )
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                        
                        NavigationLink {
                            ChangePasswordView()
                                .navigationBarBackButtonHidden()
                        } label: {
                            SettingRowView(
                                icon: "key",
                                title: "change_password",
                                subtitle: "update_security_password",
                                iconColor: .green
                            )
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
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
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    } header: {
                        Text("notification_text")
                    }
                    
                    Section {
                        ToggleRowView(
                            icon: "moon.fill",
                            title: "dark_mode",
                            subtitle: "dark_interface_for_eye",
                            iconColor: .indigo,
                            isOn: $themeViewModel.isDarkMode
                        )
                        
                        NavigationLink{
                            LanguageSettingView(appLanguage: appLanguage)
                        } label: {
                            SettingRowView(
                                icon: "globe",
                                title: "language_text",
                                subtitle: "change_app_language",
                                iconColor: .purple,
                            )
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
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
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                        
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
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                        
                        NavigationLink{
                            
                        } label: {
                            SettingRowView(
                                icon: "star",
                                title: "Đánh giá ứng dụng",
                                subtitle: "Chia sẻ trải nghiệm của bạn",
                                iconColor: .yellow
                            )
                        }
                        .listRowInsets(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
                    } header: {
                        Text("support_text")
                    }
                    
                    VStack(spacing: 16) {
                        Button(action: {
                            showSignOutAlert.toggle()
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
                    .alert("confirm_sign_out", isPresented: $showSignOutAlert) {
                        Button("cancel_text", role: .cancel) {}
                        Button("sign_out_text", role: .destructive){
                            onSignOut()
                            isLoading = true
                        }
                    } message: {
                        Text("are_you_sure_signout")
                    }
                }
                .navigationTitle("setting_text")
                .navigationBarTitleDisplayMode(.automatic)
            }
        }
    }
}

#Preview {
    SettingView(appUser: .init(uid: "2311", email: "anhhihi@gmail.com"), onSignOut: {
        print("Sign Out")
    })
}
