import SwiftUI

struct EventView: View {
    let appUser: AppUser
    @State private var selectedDate = Date()
    @State private var showingYearlyEventForm = false
    @State private var showingWeeklyEventForm = false
    @State private var eventModelView = EventViewModel()

    var body: some View {
        NavigationView {
            Form {
                Section {
                    ForEach(eventModelView.eventView) { event in
                        EventItemView(appUser: appUser, event: event, type: 1)
                    }
                    
                    Button{
                        showingYearlyEventForm = true
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.blue)
                            Text("add_event")
                                .foregroundColor(.blue)
                        }
                    }
                } header: {
                    Text("event_every_year")
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))

                Section {
                    ForEach(eventModelView.eventView) { event in
                        EventItemView(appUser: appUser, event: event, type: 2)
                    }
                    
                    Button{
                        showingWeeklyEventForm = true
                    } label: {
                        HStack {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.blue)
                            Text("add_event")
                                .foregroundColor(.blue)
                        }
                    }
                } header: {
                    Text("event_every_week")
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            }
            .navigationTitle("event_text")
            .navigationBarTitleDisplayMode(.automatic)
            .sheet(isPresented: $showingYearlyEventForm) {
                AddYearlyEventView(appUser: appUser)
            }
//            .sheet(isPresented: $showingWeeklyEventForm) {
//                AddWeeklyEventView(appUser: appUser)
//            }
            .refreshable {
                do{
                    try await eventModelView.fetchEvent(for: appUser.uid)
                } catch{
                    print(error.localizedDescription)
                }
            }
        }
    }
}

#Preview {
    EventView(appUser: AppUser(uid: "2311", email: "atdevv@gmail.com"))
}
