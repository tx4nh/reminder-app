import SwiftUI

struct SignInView: View {
    @State  var email: String
    @State  var password: String
    @State var isRegister: Bool = false
    
    @Binding var appUser: AppUser
    
    var body: some View {
        VStack{
            TextFieldView(email: $email)
            SecureFieldView(password: $password)
        }
        .padding()
    }
}

#Preview {
    SignInView(email: "", password: "", appUser: .constant(AppUser(uid: "", email: "")))
}
