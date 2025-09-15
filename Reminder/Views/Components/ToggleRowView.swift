import SwiftUI

struct ToggleRowView: View {
    let icon: String
    let title: LocalizedStringKey
    let subtitle: LocalizedStringKey?
    let iconColor: Color
    @Binding var isOn: Bool
    
    init(icon: String, title: String, subtitle: String? = nil, iconColor: Color = .accentColor, isOn: Binding<Bool>) {
        self.icon = icon
        self.title = LocalizedStringKey(title)
        self.subtitle = LocalizedStringKey(subtitle ?? "")
        self.iconColor = iconColor
        self._isOn = isOn
    }
    
    var body: some View {
        HStack(spacing: 12) {
            HStack{
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .fill(iconColor.opacity(0.1))
                        .frame(width: 38, height: 38)
                    
                    Image(systemName: icon)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(iconColor)
                }
            }
            .padding(.leading, -25)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(.primary)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
            }
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .padding(.trailing, -20)
        }
        .padding(.horizontal, 16)
        .contentShape(Rectangle())
    }
}

#Preview {
    VStack(spacing: 12) {
        ToggleRowView(
            icon: "bell.badge",
            title: "Thông báo đẩy",
            subtitle: "Nhận thông báo khi có lịch hẹn",
            iconColor: .red,
            isOn: .constant(true)
        )
        
        ToggleRowView(
            icon: "speaker.wave.2",
            title: "Âm thanh",
            subtitle: "Phát âm thanh khi có thông báo",
            iconColor: .green,
            isOn: .constant(false)
        )
    }
    .padding()
}
