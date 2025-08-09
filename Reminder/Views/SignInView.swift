import SwiftUI

struct SignInView: View {
    @State var email: String
    @State var password: String
    @State var isRegister: Bool = false
    
    @Binding var appUser: AppUser
    @State private var viewModel = SignInViewModel()
    
    var body: some View {
        VStack{
            Text("Đăng Nhập")
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
                Task{
                    do{
                        let user = try await viewModel.signInWithEmail(email: email, password: password)
                        self.appUser = user
                        print("Success signin")
                    } catch{
                        print("Error")
                    }
                }
            } label: {
                Text("Đăng Nhập")
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
            
            Button {
                isRegister.toggle()
            } label: {
                Text("Bạn chưa có tài khoản ?")
                Text("Đăng Kí")
                    .underline()
            }
            .padding(.top, 15)
            .sheet(isPresented: $isRegister) {
                RegisterView(email: "", password: "", appUser: .constant(AppUser(uid: "", email: "")), viewModel: SignInViewModel())
            }
            Spacer()
        }
        .padding()
    }
}

#Preview {
    SignInView(email: "", password: "", appUser: .constant(AppUser(uid: "", email: "")))
}
