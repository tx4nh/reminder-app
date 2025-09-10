import SwiftUI

struct ProfileSettingsView: View {
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
                    // Header with Avatar
                    VStack(spacing: 16) {
                        Button(action: { showAvatarPicker = true }) {
                            ZStack {
                                Circle()
                                    .fill(Color.accentColor.opacity(0.1))
                                    .frame(width: 100, height: 100)
                                
                                Image(systemName: selectedAvatar)
                                    .font(.system(size: 50))
                                    .foregroundColor(.accentColor)
                                
                                // Edit overlay
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
                        
                        Text("Thông tin cá nhân")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Cập nhật thông tin tài khoản của bạn")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 20)
                    
                    // Form
                    VStack(spacing: 16) {
                        // Display Name
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Tên hiển thị")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.secondary)
                            
                            CustomTextFieldView(
                                icon: "person",
                                placeholder: "Nhập tên hiển thị",
                                text: $displayName
                            )
                        }
                        
                        // Email (Read-only)
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Email")
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
                                
                                Text("Chỉ đọc")
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
                        
                        // Phone Number
                        VStack(alignment: .leading, spacing: 8) {
                            Text("Số điện thoại")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.secondary)
                            
                            CustomTextFieldView(
                                icon: "phone",
                                placeholder: "Nhập số điện thoại",
                                text: $phoneNumber
                            )
                        }
                    }
                    
                    // Account Info Section
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Thông tin tài khoản")
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
                            
                            InfoRowView(
                                icon: "list.bullet",
                                title: "Tổng số lịch hẹn",
                                value: "24",
                                iconColor: .orange
                            )
                        }
                    }
                    
                    Spacer(minLength: 20)
                    
                    // Save Button
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
            .navigationTitle("Hồ sơ")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Quay lại") {
                        dismiss()
                    }
                }
            }
        }
        .sheet(isPresented: $showAvatarPicker) {
            AvatarPickerView(selectedAvatar: $selectedAvatar)
        }
        .alert("Thông báo", isPresented: $showAlert) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
        .onAppear {
            loadUserData()
        }
    }
    
    private func loadUserData() {
        // TODO: Load user data from Supabase
        displayName = "Người dùng"
        email = "user@example.com"
        phoneNumber = "+84 123 456 789"
    }
    
    private func saveProfile() {
        isLoading = true
        
        // TODO: Save profile data to Supabase
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
            alertMessage = "Thông tin đã được cập nhật thành công!"
            showAlert = true
        }
    }
}

struct CustomTextFieldView: View {
    let icon: String
    let placeholder: String
    @Binding var text: String
    @FocusState private var isFocused: Bool
    @State private var isPressed: Bool = false
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(isFocused ? .accentColor : .secondary)
                .font(.system(size: 16, weight: .medium))
                .animation(.easeInOut(duration: 0.2), value: isFocused)
            
            TextField(placeholder, text: $text)
                .focused($isFocused)
                .textInputAutocapitalization(.words)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
                .opacity(isFocused ? 0.8 : 1.0)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    isFocused ? Color.accentColor : Color(.systemGray4),
                    lineWidth: isFocused ? 2 : 1
                )
        )
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
        .animation(.easeInOut(duration: 0.2), value: isFocused)
        .onTapGesture {
            withAnimation(.spring(response: 0.2, dampingFraction: 0.8)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(response: 0.2, dampingFraction: 0.8)) {
                    isPressed = false
                }
            }
            isFocused = true
        }
    }
}

struct InfoRowView: View {
    let icon: String
    let title: String
    let value: String
    let iconColor: Color
    
    var body: some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(iconColor.opacity(0.1))
                    .frame(width: 32, height: 32)
                
                Image(systemName: icon)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(iconColor)
            }
            
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.primary)
            
            Spacer()
            
            Text(value)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.secondary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.05), radius: 2, x: 0, y: 1)
        )
    }
}

struct AvatarPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedAvatar: String
    @State private var tempSelection: String
    
    let avatarOptions = [
        "person.circle.fill",
        "person.crop.circle.fill",
        "face.smiling.fill",
        "face.dashed.fill",
        "person.2.circle.fill",
        "person.3.circle.fill"
    ]
    
    init(selectedAvatar: Binding<String>) {
        self._selectedAvatar = selectedAvatar
        self._tempSelection = State(initialValue: selectedAvatar.wrappedValue)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
                    ForEach(avatarOptions, id: \.self) { avatar in
                        Button(action: {
                            tempSelection = avatar
                        }) {
                            ZStack {
                                Circle()
                                    .fill(tempSelection == avatar ? Color.accentColor.opacity(0.2) : Color(.systemGray6))
                                    .frame(width: 80, height: 80)
                                
                                Image(systemName: avatar)
                                    .font(.system(size: 40))
                                    .foregroundColor(tempSelection == avatar ? .accentColor : .secondary)
                                
                                if tempSelection == avatar {
                                    Circle()
                                        .stroke(Color.accentColor, lineWidth: 3)
                                        .frame(width: 80, height: 80)
                                }
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .navigationTitle("Chọn avatar")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Hủy") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Chọn") {
                        selectedAvatar = tempSelection
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    ProfileSettingsView()
}