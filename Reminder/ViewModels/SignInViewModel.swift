import Foundation

enum AuthError: LocalizedError {
    case emptyEmail
    case invalidEmail
    case emptyPassword
    case passwordTooShort
    case invalidCredentials
    case userNotFound
    case networkError
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .emptyEmail:
            return "Không được để trống email"
        case .invalidEmail:
            return "Email không hợp lệ"
        case .emptyPassword:
            return "Không được để trống mật khẩu"
        case .passwordTooShort:
            return "Mật khẩu phải có ít nhất 8 ký tự"
        case .invalidCredentials:
            return "Email không tồn tại hoặc mật khẩu không khớp"
        case .userNotFound:
            return "Tài khoản không tồn tại"
        case .networkError:
            return "Lỗi kết nối mạng. Vui lòng thử lại"
        case .unknown(let error):
            return "Đã xảy ra lỗi: \(error.localizedDescription)"
        }
    }
}

@Observable
class SignInViewModel {
    func validateForm(email: String, password: String) throws {
        let trimmedEmail = email.trimmingCharacters(in: .whitespaces)
        if trimmedEmail.isEmpty {
            throw AuthError.emptyEmail
        }
        if !trimmedEmail.isValidEmail() {
            throw AuthError.invalidEmail
        }

        if password.isEmpty {
            throw AuthError.emptyPassword
        }
        if password.count < 8 {
            throw AuthError.passwordTooShort
        }
    }
    
    func registerNewUserWithEmail(email: String, password: String) async throws -> AppUser {
        try validateForm(email: email, password: password)
        
        do {
            return try await AuthManager.shared.registerNewUserWithEmail(email: email, password: password)
        } catch {
            throw mapAuthManagerError(error)
        }
    }

    func signInWithEmail(email: String, password: String) async throws -> AppUser {
        try validateForm(email: email, password: password)
        
        do {
            return try await AuthManager.shared.signInWithEmail(email: email, password: password)
        } catch {
            throw mapAuthManagerError(error)
        }
    }

    private func mapAuthManagerError(_ error: Error) -> AuthError {
        let errorString = error.localizedDescription.lowercased()
        
        if errorString.contains("user not found") || errorString.contains("no user") {
            return .userNotFound
        } else if errorString.contains("password") || errorString.contains("credential") || errorString.contains("invalid") {
            return .invalidCredentials
        } else if errorString.contains("network") || errorString.contains("connection") {
            return .networkError
        } else {
            return .unknown(error)
        }
    }
}

extension String {
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self)
    }
}
