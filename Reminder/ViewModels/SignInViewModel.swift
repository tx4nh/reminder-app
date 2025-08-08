import Foundation

@Observable
class SignInViewModel{
    func isFormValid(email: String, password: String) -> Bool {
        guard email.isValidEmail(), password.count >= 8 else{
            return false
        }
        return true
    }
    
    func registerNewUserWithEmail(email: String, password: String) async throws -> AppUser {
        if isFormValid(email: email, password: password) {
            try await registerNewUserWithEmail(email: email, password: password)
        } else {
            throw NSError()
        }
    }
    
    func signInWithEmail(email: String, password: String) async throws -> AppUser {
        if isFormValid(email: email, password: password) {
            try await signInWithEmail(email: email, password: password)
        } else {
            throw NSError()
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
