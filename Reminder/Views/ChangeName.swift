import SwiftUI

struct ChangeName: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var modelTest: ModelTest
    
    var body: some View {
        TextField("Enter New Name", text: $modelTest.name)
        Button {
            dismiss()
        } label: {
            Text("OK")
        }
        .navigationTitle("Change Name")

    }
}

#Preview {
    ChangeName(modelTest: ModelTest())
}
