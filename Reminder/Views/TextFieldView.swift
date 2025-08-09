import SwiftUI

struct TextFieldView: View {
    let placeHolder: String = "Email address"
    @Binding var email: String
    
    var body: some View {
        TextField(placeHolder, text: $email)
            .padding()
            .frame(maxWidth: .infinity)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(Color(uiColor: .label), lineWidth: 1)
            }
            .textInputAutocapitalization(.never)
    }
}

#Preview {
    TextFieldView(email: .constant(""))
}
