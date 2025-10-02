import SwiftUI

struct ButtonLoadData: View {
    @State private var isLoading = false
    @State private var rotationAngle: Double = 0
    let action: () async -> Void
    
    var body: some View {
        Button(action: handleReload) {
            Image(systemName: "arrow.clockwise")
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 44, height: 44)
                .background(isLoading ? Color.gray : Color.blue)
                .clipShape(Circle())
                .rotationEffect(.degrees(rotationAngle))
        }
        .disabled(isLoading)
    }

    func handleReload() {
        withAnimation(.linear(duration: 1).repeatForever(autoreverses: false)) {
            rotationAngle = 360
        }
        isLoading = true

        Task {
            await action()

            withAnimation {
                isLoading = false
                rotationAngle = 0
            }
        }
    }
}

#Preview {
    ButtonLoadData(action: {
        print("Rotate")
    })
}
