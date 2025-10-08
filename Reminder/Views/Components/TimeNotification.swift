import SwiftUI

struct TimeNotification: View {
    let eventName: String
    var eventTime: String

    var body: some View {
        HStack{
            Text(eventName)
                .font(.system(size: 17, weight: .medium))
                .foregroundColor(.primary)

            Spacer()

            Text(eventTime)
                .font(.system(size: 15))
                .foregroundColor(.secondary)

            Image(systemName: "chevron.right")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.secondary)
        }
        .padding(.vertical, 7)
    }
}

#Preview {
    TimeNotification(eventName: "Sự kiện năm", eventTime: "1 ngày")
}
