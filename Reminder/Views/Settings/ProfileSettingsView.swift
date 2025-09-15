import SwiftUI

struct ProfileSettingsView: View {
    let appUser: AppUser
    @Environment(\.dismiss) private var dismiss
    @State private var displayName = ""
    @State private var email = ""
    @State private var phoneNumber = ""
    @State private var selectedAvatar = "person.circle.fill"
    @State private var isLoading = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showAvatarPicker = false
    
    let avatarOptions = [
        "person.circle.fill",
        "person.crop.circle.fill",
        "face.smiling.fill",
        "face.dashed.fill",
        "person.2.circle.fill",
        "person.3.circle.fill"
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 16) {
                        Button(action: { showAvatarPicker = true }) {
                            ZStack {
                                Circle()
                                    .fill(Color.accentColor.opacity(0.1))
                                    .frame(width: 100, height: 100)
                                
                                Image(systemName: selectedAvatar)
                                    .font(.system(size: 50))
                                    .foregroundColor(.accentColor)
                                
                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        ZStack {
                                            Circle()
                                                .fill(Color.accentColor)
                                                .frame(width: 28, height: 28)
                                            
                                            Image(systemName: "pencil")
                                                .font(.system(size: 12, weight: .medium))
                                                .foregroundColor(.white)
                                        }
                                        .offset(x: -8, y: -8)
                                    }
                                }
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Text("personal_information")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .padding(.top, 20)
                    
                    VStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("display_name")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.secondary)
                            
                            CustomTextFieldView(
                                icon: "person",
                                placeholder: "enter_display_name",
                                text: $displayName
                            )
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("email_text")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.secondary)
                            
                            HStack(spacing: 12) {
                                Image(systemName: "envelope")
                                    .foregroundColor(.secondary)
                                    .font(.system(size: 16, weight: .medium))
                                
                                Text(email.isEmpty ? "user@example.com" : email)
                                    .font(.system(size: 16))
                                    .foregroundColor(.secondary)
                                
                                Spacer()
                                
                                Text("read_only")
                                    .font(.system(size: 12))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color.gray.opacity(0.2))
                                    .cornerRadius(4)
                                    .foregroundColor(.secondary)
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 14)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color(.systemGray6))
                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color(.systemGray4), lineWidth: 1)
                            )
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        Text("account_information")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.primary)
                            .padding(.horizontal, 4)
                        
                        VStack(spacing: 8) {
                            InfoRowView(
                                icon: "calendar",
                                title: "Ngày tạo tài khoản",
                                value: "15/03/2024",
                                iconColor: .blue
                            )
                            
                            InfoRowView(
                                icon: "clock",
                                title: "Lần đăng nhập cuối",
                                value: "Hôm nay, 14:30",
                                iconColor: .green
                            )
                        }
                    }
                    
                    Spacer(minLength: 20)
                    
                    Button(action: saveProfile) {
                        HStack {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(0.8)
                            }
                            Text(isLoading ? "Đang lưu..." : "Lưu thay đổi")
                                .font(.system(size: 16, weight: .semibold))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.accentColor)
                    )
                    .foregroundColor(.white)
                    .disabled(isLoading)
                }
                .padding(.horizontal, 20)
            }
            .navigationTitle("personal_profile")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("comeback_text") {
                        dismiss()
                    }
                }
            }
        }
        .sheet(isPresented: $showAvatarPicker) {
            AvatarPickerView(selectedAvatar: $selectedAvatar)
        }
        .alert("notification_text", isPresented: $showAlert) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
        .onAppear {
            loadUserData()
        }
    }
    
    private func loadUserData() {
        displayName = "Người dùng"
        email = appUser.email ?? "Email"
    }
    
    private func saveProfile() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
            alertMessage = "Thông tin đã được cập nhật thành công!"
            showAlert = true
        }
    }
}

#Preview {
    ProfileSettingsView(appUser: .init(uid: "2311", email: "anhhihi@gmai.com"))
}
