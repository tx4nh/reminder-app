import SwiftUI

struct RegisterView: View {
    @State var email: String = ""
    @State var password: String = ""
    
    @Binding var appUser: AppUser?
    @Bindable var viewModel: SignInViewModel
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            Text("Đăng Kí")
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
            SecureFieldView(password: $password)
            
            Button {
                Task{
                    do{
                        let user = try await viewModel.registerNewUserWithEmail(email: email, password: password)
                        self.appUser = user
                        dismiss.callAsFunction()
                    }
                    catch{
                        print("Error")
                    }
                }
            } label: {
                Text("Đăng Kí")
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
    }
}

#Preview {
    RegisterView(appUser: .constant(nil), viewModel: SignInViewModel())
}
