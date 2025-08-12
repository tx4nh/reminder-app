import SwiftUI

struct AddCalendarView: View {
    @State private var selectedDate = Date()
    
    var body: some View {
        VStack{
            DatePicker("Pick date", selection: $selectedDate, displayedComponents: .hourAndMinute)
                .padding()
            
            Button {
                print(selectedDate)
                let calendar = Calendar.current
                let hour = calendar.component(.hour, from: selectedDate)
                let minute = calendar.component(.minute, from: selectedDate)
                print("\(hour): \(minute)")
                
            } label: {
                Text("Add")
            }
        }
    }
}

#Preview {
    AddCalendarView()
}
