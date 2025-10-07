import SwiftUI

struct SignInView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    @Binding var appUser: AppUser?
    @State private var viewModel = SignInViewModel()
    @State private var isLoading: Bool = false
    
    @State private var errorMessage: String = ""
    @State private var showError: Bool = false
    
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
                        .onChange(of: email) { _, _ in
                            clearError()
                        }

                    SecureFieldView(password: $password)
                        .onChange(of: password) { _, _ in
                            clearError()
                        }
                    
                    if showError {
                        Text(errorMessage)
                            .font(.caption)
                            .foregroundColor(.red)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)
                            .padding(.top, 8)
                            .transition(.opacity)
                    }
                    
                    Button {
                        handleSignIn()
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

    private func handleSignIn() {
        isLoading = true
        
        Task { @MainActor in
            do {
                let user = try await viewModel.signInWithEmail(email: email, password: password)
                self.appUser = user
                self.isLoading = false
            } catch let error as AuthError {
                self.isLoading = false
                self.errorMessage = error.errorDescription ?? "Đã xảy ra lỗi"
                withAnimation {
                    self.showError = true
                }
            } catch {
                self.isLoading = false
                self.errorMessage = "Email không tồn tại hoặc mật khẩu không khớp"
                withAnimation {
                    self.showError = true
                }
            }
        }
    }

    private func clearError() {
        if showError {
            withAnimation {
                showError = false
            }
        }
    }
}

#Preview {
    SignInView(appUser: .constant(nil))
}
