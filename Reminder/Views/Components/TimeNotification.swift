import SwiftUI

struct TimeNotification: View {
    let eventName: String
    @Binding var selectedTime: String
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Text(eventName)
                    .font(.system(size: 17, weight: .medium))
                    .foregroundColor(.primary)

                Spacer()

                Text(selectedTime)
                    .font(.system(size: 15))
                    .foregroundColor(.secondary)

                Image(systemName: "chevron.right")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 7)
        }
    }
}

#Preview {
    TimeNotification(
        eventName: "Sự kiện năm",
        selectedTime: .constant("1 ngày"),
        action: {
            print("Time picker")
        }
    )
}
