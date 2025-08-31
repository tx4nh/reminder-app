import SwiftUI

struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    @Binding var appUser: AppUser?
    @State private var viewModel = SignInViewModel()
    
    var body: some View {
        NavigationStack {
            VStack{
                Text("Reminder")
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(.blue.opacity(0.8))
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
                
                Image("icon-rmbg")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
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
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.blue.opacity(0.9))
                        )
                }
                .padding(.top, 15)
                .padding(.horizontal, 70)

                NavigationLink(destination: {
                    RegisterView(
                        email: "",
                        password: "",
                        appUser: $appUser,
                        viewModel: SignInViewModel()
                    )
                }, label: {
                    HStack(spacing: 4) {
                        Text("Bạn chưa có tài khoản ?")
                            .foregroundColor(.primary)
                        Text("Đăng Kí")
                            .foregroundColor(.blue)
                            .underline()
                    }
                })
                .padding(.top, 15)
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    SignInView(appUser: .constant(nil))
}
