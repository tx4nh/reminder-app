import SwiftUI
import Supabase

struct ChangePasswordView: View {
    let appUser: AppUser
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
                    VStack(spacing: 8) {
                        Image(systemName: "key.fill")
                            .font(.system(size: 40))
                            .foregroundColor(.accentColor)
                    }
                    .padding(.top, 20)
                    
                    VStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            Text("current_password")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.secondary)
                            
                            SecureFieldView(password: $currentPassword)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("new_password")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.secondary)
                            
                            SecureFieldView(password: $newPassword)
                        }
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text("confirm_new_password")
                                .font(.system(size: 14, weight: .medium))
                                .foregroundColor(.secondary)
                            
                            SecureFieldView(password: $confirmPassword)
                        }
                    }
                    
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
        guard isFormValid else { return }
        
        isLoading = true
        
        Task {
            guard let email = appUser.email, !email.isEmpty else {
                alertMessage = "Không thể xác định email người dùng"
                showAlert = true
                return
            }

            do {
                _ = try await supabase.auth.signIn(email: email, password: currentPassword)
                
                try await supabase.auth.update(user: UserAttributes(password: newPassword))
                
                await MainActor.run {
                    isLoading = false
                    alertMessage = "Mật khẩu đã được cập nhật thành công!"
                    showAlert = true
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        dismiss()
                    }
                }

            } catch {
//                await MainActor.run {
                    isLoading = false
                    if error.localizedDescription.contains("Invalid login credentials") {
                        alertMessage = "Mật khẩu hiện tại không chính xác"
                    } else {
                        alertMessage = "Lỗi: \(error.localizedDescription)"
                    }
                    showAlert = true
//                }
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
    ChangePasswordView(appUser: .init(uid: "2311", email: "atdevv@gmail.com"))
}
