import SwiftUI

struct SecureFieldView: View {
    let placeHolder: String = "Password"
    @Binding var password: String
    
    var body: some View {
        SecureField(placeHolder, text: $password)
            .padding()
            .frame(maxWidth: .infinity)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(uiColor: .label), lineWidth: 1)
            }
    }
}

#Preview {
    SecureFieldView(password: .constant(""))
}
