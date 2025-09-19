import SwiftUI

struct DateListView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach(0...20, id: \.self) { day in
                    DateView(day: day)
                        .padding(.vertical, 2)
                        .padding(.horizontal, 3)
                }            }
        }

    }
}

#Preview {
    DateListView()
}
