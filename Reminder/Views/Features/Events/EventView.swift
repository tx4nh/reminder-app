import SwiftUI

struct EventView: View {
    @State private var selectedDate = Date()

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("select_date")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                DatePicker(
                    "choose_date",
                    selection: $selectedDate,
                )
                .labelsHidden()
                
                Text("selected_time")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text(selectedDate.formatted(date: .complete, time: .shortened))
                    .font(.headline)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                
                Spacer()
            }
            .padding()
            .navigationTitle("event_text")
        }
    }
}

#Preview {
    EventView()
}
