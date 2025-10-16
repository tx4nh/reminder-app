import SwiftUI

struct SoundPickerView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedSound: String
    @State private var tempSelection: String
    
    init(selectedSound: Binding<String>) {
        self._selectedSound = selectedSound
        self._tempSelection = State(initialValue: selectedSound.wrappedValue)
    }
    
    private func getSoundName(from file: String) -> String {
        soundOptions.first(where: { $0.file == file })?.name ?? "Mặc định"
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
                        
                        if tempSelection == soundFile {
                            Image(systemName: "checkmark")
                                .foregroundColor(.accentColor)
                                .font(.system(size: 16, weight: .semibold))
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        SoundManeger.shared.playSound(named: soundFile)
                        tempSelection = soundFile
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
    SoundPickerView(selectedSound: .constant("sound1"))
}
