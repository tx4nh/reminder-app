import SwiftUI

struct RegisterView: View {
    @State var email: String
    @State var password: String
    
    @Binding var appUser: AppUser
    @Bindable var viewModel: SignInViewModel
    @Environment(\.dismiss) var dismiss
    
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
    RegisterView(email: "", password: "", appUser: .constant(AppUser(uid: "", email: "")), viewModel: SignInViewModel())
}

//import SwiftUI
//
//struct RegisterView: View {
//    @Environment(\.dismiss) var dismiss
//    @State private var email: String = ""
//    @State private var password: String = ""
//    
//    @Bindable var viewModel: SignInViewModel
//    @Binding var appUser: AppUser?
//    
//    var body: some View {
//        VStack {
//            VStack {
//                TextFieldView(email: $email)
//                SecureFieldView(password: $password)
//                Button {
//                    Task {
//                        print("🔘 Button tapped - Email: '\(email)', Password length: \(password.count)")
//                        
//                        do {
//                            print("🚀 Calling registerNewUserWithEmail...")
//                            let registeredUser = try await viewModel.registerNewUserWithEmail(email: email, password: password)
//                            print("✅ SUCCESS! Got user: \(registeredUser)")
//                            
//                            // Test 1: Chỉ print, không set appUser
//                            print("🔄 Would set appUser to: \(registeredUser)")
//                            
//                            // Test 2: Set appUser trên main thread
//                            await MainActor.run {
//                                print("🔄 Setting appUser on main thread...")
//                                self.appUser = registeredUser
//                                print("✅ appUser set successfully: \(String(describing: self.appUser))")
//                            }
//                            
//                            // Test 3: Dismiss sau khi set thành công
//                            await MainActor.run {
//                                print("🔄 Dismissing view...")
//                                dismiss()
//                            }
//                            
//                        } catch {
//                            print("❌ CAUGHT ERROR: \(error)")
//                            print("❌ Error type: \(type(of: error))")
//                            print("❌ Error description: \(error.localizedDescription)")
//                            
//                            // Đây là nơi in ra "Issue email password"
//                            print("Issue: \(email) \(password)")
//                        }
//                    }
//                } label: {
//                    Text("Register")
//                        .padding()
//                        .frame(maxWidth: .infinity)
//                        .frame(height: 55)
//                        .foregroundStyle(Color(uiColor: .systemBackground))
//                        .background {
//                            RoundedRectangle(cornerRadius: 20)
//                                .foregroundStyle(Color(uiColor: .label))
//                        }
//                }
//                .padding(.vertical, 24)
//                .padding(.horizontal, 70)
//            }
//            .padding()
//        }
//        .onAppear {
//            print("📱 RegisterView appeared")
//        }
//    }
//}
//
//#Preview {
//    RegisterView(viewModel: SignInViewModel(), appUser: .constant(nil))
//}
