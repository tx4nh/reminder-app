import SwiftUI

struct AvatarPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedAvatar: String
    @State private var tempSelection: String
    
    let avatarOptions = [
        "person.circle.fill",
        "person.crop.circle.fill",
        "face.smiling.fill",
        "face.dashed.fill",
        "person.2.circle.fill",
        "person.3.circle.fill"
    ]
    
    init(selectedAvatar: Binding<String>) {
        self._selectedAvatar = selectedAvatar
        self._tempSelection = State(initialValue: selectedAvatar.wrappedValue)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3), spacing: 20) {
                    ForEach(avatarOptions, id: \.self) { avatar in
                        Button(action: {
                            tempSelection = avatar
                        }) {
                            ZStack {
                                Circle()
                                    .fill(tempSelection == avatar ? Color.accentColor.opacity(0.2) : Color(.systemGray6))
                                    .frame(width: 80, height: 80)
                                
                                Image(systemName: avatar)
                                    .font(.system(size: 40))
                                    .foregroundColor(tempSelection == avatar ? .accentColor : .secondary)
                                
                                if tempSelection == avatar {
                                    Circle()
                                        .stroke(Color.accentColor, lineWidth: 3)
                                        .frame(width: 80, height: 80)
                                }
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .padding()
            }
            .navigationTitle("select_avatar")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("cancel_text") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("select_text") {
                        selectedAvatar = tempSelection
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}

#Preview {
    AvatarPickerView(selectedAvatar: .constant("person.circle.fill"))
}
