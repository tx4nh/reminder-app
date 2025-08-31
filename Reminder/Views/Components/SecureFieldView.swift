import SwiftUI

struct SecureFieldView: View {
    @Binding var password: String
    @State private var isPasswordVisible: Bool = false
    @FocusState private var isFocused: Bool
    @State private var isPressed: Bool = false
    @State private var isEyePressed: Bool = false
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: "lock")
                .foregroundColor(isFocused ? .accentColor : .secondary)
                .font(.system(size: 16, weight: .medium))
                .animation(.easeInOut(duration: 0.2), value: isFocused)
            
            Group {
                if isPasswordVisible {
                    TextField("Password", text: $password)
                        .focused($isFocused)
                } else {
                    SecureField("Password", text: $password)
                        .focused($isFocused)
                }
            }
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            
            Button(action: {
                let wasFocused = isFocused
                withAnimation(.spring(response: 0.2, dampingFraction: 0.8)) {
                    isEyePressed = true
                }
                withAnimation(.easeInOut(duration: 0.2)) {
                    isPasswordVisible.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.spring(response: 0.2, dampingFraction: 0.8)) {
                        isEyePressed = false
                    }
                    if wasFocused {
                        isFocused = true
                    }
                }
            }) {
                Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                    .foregroundColor(.secondary)
                    .font(.system(size: 16, weight: .medium))
                    .scaleEffect(isEyePressed ? 0.9 : 1.0)
                    .animation(.spring(response: 0.2, dampingFraction: 0.8), value: isEyePressed)
            }
            .buttonStyle(PlainButtonStyle())
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
    SecureFieldView(password: .constant(""))
}