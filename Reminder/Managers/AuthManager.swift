import Foundation

class AuthManager {
    static let shared = AuthManager()
    
    func registerNewUserWithEmail(email: String, password: String) async throws -> AppUser {
        let regAuth = try await supabase.auth.signUp(email: email, password: password)
        guard let session = regAuth.session else {
            throw NSError()
        }
        return AppUser(uid: session.user.id.uuidString, email: session.user.email)
    }
    
    func signInWithEmail(email: String, password: String) async throws -> AppUser{
        let session = try await supabase.auth.signIn(email: email, password: password)
        return AppUser(uid: session.user.id.uuidString, email: session.user.email)
    }
}
