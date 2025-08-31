import SwiftUI

struct TextFieldView: View {
    @Binding var email: String
    @FocusState private var isFocused: Bool
    @State private var isPressed: Bool = false
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "envelope")
                .foregroundColor(isFocused ? .accentColor : .secondary)
                .font(.system(size: 16, weight: .medium))
                .animation(.easeInOut(duration: 0.2), value: isFocused)
            
            TextField("Email", text: $email)
                .focused($isFocused)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemGray6))
                .opacity(isFocused ? 0.8 : 1.0)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    isFocused ? Color.accentColor : Color(.systemGray4),
                    lineWidth: isFocused ? 2 : 1
                )
        )
        .scaleEffect(isPressed ? 0.98 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
        .animation(.easeInOut(duration: 0.2), value: isFocused)
        .onTapGesture {
            withAnimation(.spring(response: 0.2, dampingFraction: 0.8)) {
                isPressed = true
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                withAnimation(.spring(response: 0.2, dampingFraction: 0.8)) {
                    isPressed = false
                }
            }
            isFocused = true
        }
    }
}

#Preview {
    TextFieldView(email: .constant(""))
}