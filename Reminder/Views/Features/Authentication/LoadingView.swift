import SwiftUI

struct LoadingView: View {
    @State private var themeViewModel = ThemeViewModel()
    @State private var isRotating = false
    
    var body: some View {
        ZStack {
            Color(themeViewModel.isDarkMode ? .black : .white)                .ignoresSafeArea()
            
            Circle()
                .trim(from: 0, to: 0.7)
                .stroke(
                    LinearGradient(
                        colors: [.blue, .cyan],
                        startPoint: .topTrailing,
                        endPoint: .bottomLeading
                    ),
                    style: StrokeStyle(
                        lineWidth: 4,
                        lineCap: .round
                    )
                )
                .frame(width: 50, height: 50)
                .rotationEffect(.degrees(isRotating ? 360 : 0))
                .animation(
                    .linear(duration: 1.0)
                    .repeatForever(autoreverses: false),
                    value: isRotating
                )
                .onAppear {
                    isRotating = true
                }
        }
    }
}

#Preview {
    LoadingView()
}
