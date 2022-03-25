import SwiftUI
import CoreData

struct ContentView: View {
    @State var showAppSettings = false
    @State var showAddDialog = false
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var armies: FetchedResults<Army>
    
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
                VStack(){
                    ForEach(armies, id: \.id){ army in
                        NavigationLink(destination: armyDetailedView(army: army).onAppear(perform:{ Haptics.shared.play(.light)})) {
                            armyView(army: army)
                        }
                        
                    }
                }
            
            }.navigationTitle("Your armies").toolbar {
                ToolbarItemGroup(placement: .primaryAction){
                    Button(action: {
                        self.showAddDialog.toggle()
                    }) {
                        Label("Add",systemImage:"plus.app")}.sheet(isPresented:$showAddDialog){
                            addArmyDialog(moc)
                        }

                    }
            }.toolbar{
                ToolbarItemGroup(placement: .navigationBarLeading){
                    Button(action:{
                        self.showAppSettings.toggle()
                        
                    }) {
                        Label("Settings",systemImage:"gear")
                    }.sheet(isPresented:$showAppSettings){
                        appSettings()
                    }
                }
            }
            }
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
