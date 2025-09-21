import SwiftUI

struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    @Binding var appUser: AppUser?
    @State private var viewModel = SignInViewModel()
    @State private var isLoading: Bool = false
    
    var body: some View {
        if isLoading {
            LoadingView()
        } else {
            NavigationStack {
                VStack{
                    Text("app_name")
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
                        .padding(.bottom, 10)
                    SecureFieldView(password: $password)
                    
                    Button {
                        isLoading = true
                        Task {
                            do {
                                let user = try await viewModel.signInWithEmail(email: email, password: password)
                                self.appUser = user
                                isLoading = false
                            } catch {
                                isLoading = false
                                print("error")
                            }
                        }
                    } label: {
                        Text("sign_in_text")
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
                            Text("you_no_account")
                                .foregroundColor(.primary)
                            Text("register_text")
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
}

#Preview {
    SignInView(appUser: .constant(nil))
}
