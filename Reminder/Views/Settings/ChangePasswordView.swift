import SwiftUI

struct ChangePasswordView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var currentPassword = ""
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var isLoading = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Header
                    VStack(spacing: 8) {
                        Image(systemName: "key.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.accentColor)
                        
                        Text("change_password")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Text("Nhập mật khẩu hiện tại và mật khẩu mới")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding(.top, 20)
                    
                    // Form
                    VStack(spacing: 16) {
                        // Current Password
                        VStack(alignment: .leading, spacing: 8) {
                            Text("current_password")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.secondary)
                            
                            SecureFieldView(password: $currentPassword)
                        }
                        
                        // New Password
                        VStack(alignment: .leading, spacing: 8) {
                            Text("new_password")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.secondary)
                            
                            SecureFieldView(password: $newPassword)
                        }
                        
                        // Confirm Password
                        VStack(alignment: .leading, spacing: 8) {
                            Text("confirm_new_password")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.secondary)
                            
                            SecureFieldView(password: $confirmPassword)
                        }
                    }
                    
                    // Password Requirements
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Yêu cầu mật khẩu:")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.secondary)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            RequirementRow(text: "Ít nhất 8 ký tự", isValid: newPassword.count >= 8)
                            RequirementRow(text: "Có chữ hoa và chữ thường", isValid: containsUpperAndLower(newPassword))
                            RequirementRow(text: "Có ít nhất 1 số", isValid: containsNumber(newPassword))
                            RequirementRow(text: "Mật khẩu khớp nhau", isValid: !newPassword.isEmpty && newPassword == confirmPassword)
                        }
                    }
                    .padding(.horizontal, 4)
                    
                    Spacer(minLength: 20)
                    
                    // Change Password Button
                    Button(action: changePassword) {
                        HStack {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(0.8)
                            }
                            Text(isLoading ? "Đang cập nhật..." : "change_password")
                                .font(.system(size: 16, weight: .semibold))
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(isFormValid ? Color.accentColor : Color.gray)
                    )
                    .foregroundColor(.white)
                    .disabled(!isFormValid || isLoading)
                }
                .padding(.horizontal, 20)
            }
            .navigationTitle("change_password")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("delete_text") {
                        dismiss()
                    }
                }
            }
        }
        .alert("notification_text", isPresented: $showAlert) {
            Button("OK") { }
        } message: {
            Text(alertMessage)
        }
    }
    
    private var isFormValid: Bool {
        !currentPassword.isEmpty &&
        !newPassword.isEmpty &&
        !confirmPassword.isEmpty &&
        newPassword.count >= 8 &&
        containsUpperAndLower(newPassword) &&
        containsNumber(newPassword) &&
        newPassword == confirmPassword
    }
    
    private func containsUpperAndLower(_ password: String) -> Bool {
        let hasUppercase = password.range(of: "[A-Z]", options: .regularExpression) != nil
        let hasLowercase = password.range(of: "[a-z]", options: .regularExpression) != nil
        return hasUppercase && hasLowercase
    }
    
    private func containsNumber(_ password: String) -> Bool {
        return password.range(of: "[0-9]", options: .regularExpression) != nil
    }
    
    private func changePassword() {
        isLoading = true
        
        // TODO: Implement password change logic with Supabase
        // This is where you'll call your Supabase auth update password method
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
            alertMessage = "Mật khẩu đã được cập nhật thành công!"
            showAlert = true
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                dismiss()
            }
        }
    }
}

struct RequirementRow: View {
    let text: String
    let isValid: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: isValid ? "checkmark.circle.fill" : "circle")
                .font(.system(size: 12))
                .foregroundColor(isValid ? .green : .secondary)
            
            Text(text)
                .font(.system(size: 12))
                .foregroundColor(isValid ? .primary : .secondary)
            
            Spacer()
        }
    }
}

#Preview {
    ChangePasswordView()
}
