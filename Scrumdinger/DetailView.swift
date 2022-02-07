import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    
    @State var isDisplayingEditView = false
    @State private var data: DailyScrum.Data = DailyScrum.Data()
    
    var body: some View {
        List {
            Section("Meeting Info") {
                NavigationLink(destination: MeetingView()) {
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }
                HStack {
                    Label("Length", systemImage: "clock")
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                .accessibilityElement(children: .combine)
                HStack {
                    Label("Theme", systemImage: "paintpalette")
                    Spacer()
                    Text(scrum.theme.name)
                        .padding(4)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
            }
            Section("Attendees") {
                ForEach(scrum.attendees) { attendee in
                    Label(attendee.name, systemImage: "person")
                }
            }
        }
        .toolbar{
            Button(action: {
                isDisplayingEditView = true
                data = scrum.data
            }) {
                Text("Edit")
            }
        }
        .navigationTitle(scrum.title)
        .sheet(isPresented: $isDisplayingEditView, onDismiss: {}) {
            NavigationView() {
                DetailEditView(data: $data)
                    .navigationTitle(scrum.title)
                    .toolbar {
                        ToolbarItem(placement: ToolbarItemPlacement.cancellationAction) {
                            Button("Cancel") {
                                isDisplayingEditView = false
                            }
                        }
                        ToolbarItem(placement: ToolbarItemPlacement.confirmationAction) {
                            Button("Done") {
                                scrum.update(from: data)
                                isDisplayingEditView = false
                            }
                        }
                    }
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
