import Foundation
import SwiftUI

struct AddWeeklyEventView: View {
    @Binding var events: [WeeklyEvent]
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var selectedDayOfWeek = 2
    
    private let weekDays = [
        (1, "Chủ Nhật"), (2, "Thứ 2"), (3, "Thứ 3"), (4, "Thứ 4"),
        (5, "Thứ 5"), (6, "Thứ 6"), (7, "Thứ 7")
    ]
    
    var body: some View {
        NavigationView {
            Form {
                Section("Thông tin sự kiện") {
                    TextField("Tên sự kiện", text: $title)
                    
                    Picker("Ngày trong tuần", selection: $selectedDayOfWeek) {
                        ForEach(weekDays, id: \.0) { day in
                            Text(day.1).tag(day.0)
                        }
                    }
                }
            }
            .navigationTitle("Thêm sự kiện hàng tuần")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Hủy") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Lưu") {
                        let newEvent = WeeklyEvent(
                            id: (events.map { $0.id }.max() ?? 0) + 1,
                            title: title,
                            dayOfWeek: selectedDayOfWeek,
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
