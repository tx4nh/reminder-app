import Foundation
import SwiftUI

struct AddYearlyEventView: View {
    @Binding var events: [YearlyEvent]
    @Environment(\.dismiss) private var dismiss

    @State private var title = ""
    @State private var selectedDate = Date()

    private let availableIcons = [
        "calendar", "gift", "sparkles", "flag", "moon.stars",
        "heart", "star", "party.popper", "balloon", "cake"
    ]

    var body: some View {
        NavigationView {
            Form {
                Section("Thông tin sự kiện") {
                    TextField("Tên sự kiện", text: $title)
                    
                    DatePicker("Chọn ngày", selection: $selectedDate, displayedComponents: [.date])
                        .datePickerStyle(.compact)
                }
            }
            .navigationTitle("Thêm sự kiện hàng năm")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Hủy") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Lưu") {
                        let newEvent = YearlyEvent(
                            id: (events.map { $0.id }.max() ?? 0) + 1,
                            title: title,
                            date: selectedDate
                        )
                        events.append(newEvent)
                        dismiss()
                    }
                    .disabled(title.isEmpty)
                }
            }
        }
    }
}
