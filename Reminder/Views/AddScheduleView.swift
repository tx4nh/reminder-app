import SwiftUI

struct AddScheduleView: View {
    let appUser: AppUser
    @State private var selectedDate = Date()
    @State private var text: String = ""
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                HStack(spacing: 8) {
                    Image(systemName: "calendar.badge.plus")
                        .font(.system(size: 48))
                        .foregroundColor(.blue)
                    
                    Text("Thêm Lịch Trình Mới")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)

                }
                .padding(.top, 20)
                
                Spacer()
                
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "text.document")
                                .foregroundColor(.blue)
                                .font(.title3)
                            Text("Nội dung công việc")
                                .font(.title3)
                                .fontWeight(.medium)
                                .foregroundColor(.primary)
                        }
                        
                        VStack(alignment: .leading, spacing: 6) {
                            TextField("Nhập việc cần làm hôm nay...", text: $text, axis: .vertical)
                                .frame(height: 100)
                                .textFieldStyle(PlainTextFieldStyle())
                                .font(.body)
                                .padding(.horizontal, 16)
                                .padding(.vertical, 12)
                                .background(Color(.systemBackground))
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(text.isEmpty ? Color.gray.opacity(0.3) : Color.blue.opacity(0.5), lineWidth: 1)
                                )
                            
                            Text("Mô tả chi tiết về công việc bạn cần hoàn thành")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 4)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 12) {
                        HStack {
                            Image(systemName: "clock.fill")
                                .foregroundColor(.orange)
                                .font(.title3)
                            Text("Thời gian thông báo")
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        
                        HStack {
                            DatePicker("",
                                     selection: $selectedDate,
                                     displayedComponents: .hourAndMinute)
                                .datePickerStyle(CompactDatePickerStyle())
                                .labelsHidden()
                            
                            Spacer()
                            
                            VStack(alignment: .trailing) {
                                Text("Thời gian đã chọn")
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(formatTime(selectedDate))
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(.orange)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 12)
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.orange.opacity(0.3), lineWidth: 1)
                        )
                    }
                }
                .padding(.horizontal, 20)
                
                Spacer()
                
                VStack(spacing: 12) {
                    Button(action: {
                        addSchedule()
                    }) {
                        HStack {
                            Image(systemName: "plus.circle.fill")
                            Text("Thêm Lịch Trình")
                                .fontWeight(.semibold)
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(
                            LinearGradient(
                                colors: [Color.blue, Color.blue.opacity(0.8)],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .cornerRadius(12)
                    }
                    .disabled(text.isEmpty)
                    .opacity(text.isEmpty ? 0.6 : 1.0)
                    
                    Button("Hủy") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    .foregroundColor(.secondary)
                    .frame(maxWidth: .infinity, minHeight: 44)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .navigationBarHidden(true)
            .background(Color(.systemGroupedBackground))
        }
    }
    
    private func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.locale = Locale(identifier: "vi_VN")
        return formatter.string(from: date)
    }
    
    private func addSchedule() {
        print(selectedDate)
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: selectedDate)
        let minute = calendar.component(.minute, from: selectedDate)
        let time = String(format: "%02d:%02d", hour, minute)
        
        print(text, time, separator: " ")
        
        // Task{
        //     do{
        //         try await ScheduleViewModel().insertSchedule(user_uid: appUser.uid, text: text, time: time)
        //         presentationMode.wrappedValue.dismiss()
        //     } catch{
        //         print(error)
        //     }
        // }
        
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    AddScheduleView(appUser: .init(uid: "123", email: "keke@gmail.com"))
}
