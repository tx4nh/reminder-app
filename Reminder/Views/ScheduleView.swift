import SwiftUI

struct ScheduleView: View {
    @State private var viewModel = ScheduleViewModel()
    
    var body: some View {
        ZStack{
            LazyVStack{
                ForEach(viewModel.test, id: \.text) { schedule in
                    Text(schedule.text)
                }
            }
        }
    }
}

#Preview {
    ScheduleView()
}
