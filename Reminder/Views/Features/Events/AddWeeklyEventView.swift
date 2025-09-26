import Foundation
import SwiftUI

struct AddWeeklyEventView: View {
    @Binding var events: [WeeklyEvent]
    @Environment(\.dismiss) private var dismiss
    
    @State private var title = ""
    @State private var selectedDayOfWeek = 2
    
    private let weekDays = [
        "Chủ Nhật", "Thứ 2", "Thứ 3", "Thứ 4", "Thứ 5",  "Thứ 6", "Thứ 7"
    ]
    
    var body: some View {
        VStack(spacing: 20) {
            RoundedRectangle(cornerRadius: 2)
                .fill(Color.secondary.opacity(0.3))
                .frame(width: 36, height: 4)
                .padding(.top, 8)
            
            VStack(spacing: 16) {
                Text("Thêm sự kiện hàng tuần")
                    .font(.title3)
                    .fontWeight(.semibold)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Tên sự kiện")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    
                    TextField("Nhập tên sự kiện", text: $title)
                        .frame(height: 40)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 10)
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.systemGray4), lineWidth: 1)
                        )
                        .font(.system(size: 16))
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("Thời gian thông báo")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Text(weekDays[selectedDayOfWeek - 1])
                            .font(.system(size: 16))
                            .foregroundColor(.primary)

                        Spacer()

                        Picker("Ngày trong tuần", selection: $selectedDayOfWeek) {
                            ForEach(weekDays.indices, id: \.self) { index in
                                Text(weekDays[index]).tag(index + 1)
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.vertical, 10)
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color(.systemGray4), lineWidth: 1)
                    )
                }
            }
            .padding(.horizontal, 20)
            
            Spacer()

            HStack(spacing: 12) {
                Button("Hủy") {
                    dismiss()
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(.regularMaterial)
                .cornerRadius(8)
                
                Button("Lưu") {
                    dismiss()
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .presentationDetents([.height(370)])
    }
}

#Preview {
    AddWeeklyEventView(events: .constant([]))
}
