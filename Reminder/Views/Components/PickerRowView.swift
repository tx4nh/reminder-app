import SwiftUI

struct PickerRowView: View {
    let icon: String
    let title: String
    let subtitle: String?
    let iconColor: Color
    let currentValue: String
    let action: () -> Void
    
    @State private var isPressed: Bool = false
    
    init(icon: String, title: String, subtitle: String? = nil, iconColor: Color = .accentColor, currentValue: String, action: @escaping () -> Void) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.iconColor = iconColor
        self.currentValue = currentValue
        self.action = action
    }
    
    var body: some View {
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
                            .frame(width: 40, height: 40)
                        
                        Image(systemName: icon)
                            .font(.system(size: 20, weight: .medium))
                            .foregroundColor(iconColor)
                    }
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    Text(title)
                        .font(.system(size: 17, weight: .medium))
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
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.secondary)
                }
            }
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

#Preview {
    VStack(spacing: 12) {
        PickerRowView(
            icon: "speaker.wave.3",
            title: "Âm thanh thông báo",
            subtitle: "Chọn âm thanh",
            iconColor: .purple,
            currentValue: "Mặc định"
        ) {
            print("Sound picker tapped")
        }
        
        PickerRowView(
            icon: "globe",
            title: "Ngôn ngữ",
            subtitle: "Thay đổi ngôn ngữ",
            iconColor: .blue,
            currentValue: "Tiếng Việt"
        ) {
            print("Language picker tapped")
        }
    }
    .padding()
}
