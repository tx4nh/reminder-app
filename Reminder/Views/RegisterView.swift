import SwiftUI

struct RegisterView: View {
    @State var email: String
    @State var password: String
    
    @Binding var appUser: AppUser
    
    var body: some View {
        VStack{
            Text("Đăng Kí")
                .font(.system(size: 28, weight: .thin))
                .foregroundColor(.primary)
                .tracking(3)
                .padding(.bottom, 10)
                .overlay(
                    LinearGradient(
                        colors: [.clear, .blue, .clear],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(height: 1)
                    .offset(y: 20)
                )
                
            Spacer()
            TextFieldView(email: $email)
            SecureFieldView(password: $password)
            
            Button {
                print("1")
            } label: {
                Text("Đăng Kí")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color(uiColor: .systemBackground))
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(uiColor: .label))
                    )
            }
            .padding(.top, 15)
            .padding(.horizontal, 70)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    RegisterView(email: "", password: "", appUser: .constant(AppUser(uid: "", email: "")))
}
