import SwiftUI

struct RegisterView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var showSuccessAlert = false
    
    @Binding var appUser: AppUser?
    @Bindable var viewModel: SignInViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Text("create_account")
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
            TextFieldView(email: $email)
                .padding(.bottom, 10)
            SecureFieldView(password: $password)
            
            Button {
                registerAPI()
            } label: {
                Text("register_text")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(Color(uiColor: .systemBackground))
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.blue.opacity(0.9))
                    )
            }
            .padding(.top, 15)
            .padding(.horizontal, 70)
            Spacer()
        }
        .padding()
        .alert(LocalizedStringKey("success_register"), isPresented: $showSuccessAlert) {
            Button("OK") {
                dismiss()
            }
        }
    }
    
    private func registerAPI() {
        Task{
            do{
                let user = try await viewModel.registerNewUserWithEmail(email: email, password: password)
                self.appUser = user
                showSuccessAlert = true
            }
            catch{
                print("Error")
            }
        }
    }
}

#Preview {
    RegisterView(appUser: .constant(nil), viewModel: SignInViewModel())
}
