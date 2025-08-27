import SwiftUI

struct SettingView: View {
    let onSignOut: () -> Void
    
    var body: some View {
        HStack {
            Text("Xin chào!")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(Color(uiColor: .label))
            Spacer()
            Button(action: {
                onSignOut()
            }, label: {
                HStack(spacing: 6) {
                    Image(systemName: "rectangle.portrait.and.arrow.right")
                        .font(.system(size: 14, weight: .medium))
                    Text("Sign Out")
                        .font(.system(size: 14, weight: .medium))
                }
            })
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.red)
                    .shadow(color: Color.red.opacity(0.3), radius: 4, x: 0, y: 2)
            )
            .foregroundColor(.white)
        }
        .padding(.horizontal, 20)
        .padding(.top, 10)
    }
}

#Preview {
    SettingView(onSignOut: {
        print("Sign Out")
    })
}
