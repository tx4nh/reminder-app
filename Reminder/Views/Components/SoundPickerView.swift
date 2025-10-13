import SwiftUI

struct SoundPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedSound: String
    @State private var tempSelection: String
    
    init(selectedSound: Binding<String>) {
        self._selectedSound = selectedSound
        self._tempSelection = State(initialValue: selectedSound.wrappedValue)
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(soundOptions, id: \.name) { sound in
                    let soundName = sound.name
                    let soundFile = sound.file

                    HStack {
                        Text(soundName)
                            .font(.system(size: 16))
                        
                        Spacer()
                        
                        if tempSelection == soundName {
                            Image(systemName: "checkmark")
                                .foregroundColor(.accentColor)
                                .font(.system(size: 16, weight: .semibold))
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        SoundManeger.shared.playSound(named: soundFile)
                        tempSelection = soundName
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
