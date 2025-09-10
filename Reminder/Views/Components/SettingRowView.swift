import SwiftUI

struct SettingRowView: View {
    let icon: String
    let title: String
    let subtitle: String?
    let iconColor: Color
    let action: () -> Void
    
    @State private var isPressed: Bool = false
    
    init(icon: String, title: String, subtitle: String? = nil, iconColor: Color = .accentColor, action: @escaping () -> Void) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.iconColor = iconColor
        self.action = action
    }
    
    var body: some View {
        VStack {
            Button(action: {
                withAnimation(.spring(response: 0.2, dampingFraction: 0.8)) {
                    isPressed = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    withAnimation(.spring(response: 0.2, dampingFraction: 0.8)) {
                        isPressed = false
                    }
                    action()
                }
            }) {
                HStack(spacing: 12) {
                    HStack {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(iconColor.opacity(0.1))
                                .frame(width: 38, height: 38)
                            
                            Image(systemName: icon)
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(iconColor)
                        }
                    }.padding(.leading, -20)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text(title)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.primary)
                        
                        if let subtitle = subtitle {
                            Text(subtitle)
                                .font(.system(size: 14))
                                .foregroundColor(.secondary)
                        }
                    }
                    
                    Spacer()
                    
                    HStack{
                        Image(systemName: "chevron.right")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.secondary)
                    }
                    .padding(.trailing, -40)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemBackground))
                )
                .scaleEffect(isPressed ? 0.98 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isPressed)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

#Preview {
    VStack(spacing: 12) {
        SettingRowView(
            icon: "key",
            title: "Đổi mật khẩu",
            subtitle: "Cập nhật mật khẩu của bạn",
            iconColor: .blue
        ) {
            print("Change password tapped")
        }
        
        SettingRowView(
            icon: "bell",
            title: "Thông báo",
            subtitle: "Âm thanh và rung",
            iconColor: .orange
        ) {
            print("Notifications tapped")
        }
    }
    .padding()
}
