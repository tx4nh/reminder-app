import SwiftUI

struct TimePickerView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedTime: String
    @State private var tempSelection: String
    
    let timeOptions = ["30 phút", "1 giờ",  "3 giờ", "5 giờ", "1 ngày", "3 ngày", "1 tuần", "2 tuần"]
    
    init(selectedTime: Binding<String>) {
        self._selectedTime = selectedTime
        self._tempSelection = State(initialValue: selectedTime.wrappedValue)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(timeOptions, id: \.self) { time in
                    HStack {
                        Text(LocalizedStringKey(time))
                            .font(.system(size: 16))
                        
                        Spacer()
                        
                        if tempSelection == time {
                            Image(systemName: "checkmark")
                                .foregroundColor(.accentColor)
                                .font(.system(size: 16, weight: .semibold))
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        tempSelection = time
                    }
                }
            }
            .navigationTitle("sound_text")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("cancel_text") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("select_text") {
                        selectedTime = tempSelection
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }

}

#Preview {
    TimePickerView(selectedTime: .constant(""))
}
