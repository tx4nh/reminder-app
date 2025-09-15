import SwiftUI

struct LanguageSettingView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var appLanguage: AppLanguageManager
    @State private var selectedLanguage: AppLanguage = .vi

    var body: some View {
        NavigationStack{
            Form{
                Section {
                    ForEach(AppLanguage.allCases) { lang in
                        HStack{
                            Text(lang.displayName)
                            
                            Spacer()
                            
                            if lang == selectedLanguage {
                               Image(systemName: "checkmark")
                                   .foregroundColor(.primary)
                           }
                        }
                        .onTapGesture {
                            selectedLanguage = lang
                        }
                    }
                }
            }
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("save_text"){
                        appLanguage.language = selectedLanguage
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarLeading) {
                    Button("cancel_text") {
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            selectedLanguage = appLanguage.language
        }
        .navigationTitle("language_text")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    LanguageSettingView(appLanguage: AppLanguageManager())
}
