import SwiftUI

struct SoundPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedSound: String
    @State private var tempSelection: String
    
    let soundOptions = ["Mặc định", "Chuông", "Báo thức", "Nhẹ nhàng", "Sôi động", "Tắt"]
    
    init(selectedSound: Binding<String>) {
        self._selectedSound = selectedSound
        self._tempSelection = State(initialValue: selectedSound.wrappedValue)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(soundOptions, id: \.self) { sound in
                    HStack {
                        Text(sound)
                            .font(.system(size: 16))
                        
                        Spacer()
                        
                        if tempSelection == sound {
                            Image(systemName: "checkmark")
                                .foregroundColor(.accentColor)
                                .font(.system(size: 16, weight: .semibold))
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        tempSelection = sound
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
                        selectedSound = tempSelection
                        dismiss()
                    }
                    .fontWeight(.semibold)
                }
            }
        }
    }
}
#Preview {
    SoundPickerView(selectedSound: .constant(""))
}
