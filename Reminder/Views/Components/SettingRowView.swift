import SwiftUI

struct SettingRowView: View {
    let icon: String
    let title: String
    let subtitle: String?
    let iconColor: Color
    
    init(icon: String, title: String, subtitle: String? = nil, iconColor: Color = .accentColor) {
        self.icon = icon
        self.title = title
        self.subtitle = subtitle
        self.iconColor = iconColor
    }
    
    var body: some View {
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
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 12)
        .contentShape(Rectangle())
    }
}

#Preview {
    VStack(spacing: 12) {
        SettingRowView(
            icon: "key",
            title: "Đổi mật khẩu",
            subtitle: "Cập nhật mật khẩu của bạn",
            iconColor: .blue
        )
        
        SettingRowView(
            icon: "bell",
            title: "Thông báo",
            subtitle: "Âm thanh và rung",
            iconColor: .orange
        )
    }
    .padding()
}
