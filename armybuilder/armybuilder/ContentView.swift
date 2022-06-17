import SwiftUI

struct ContentView: View {
    @State var showAppSettings = false
    @State var showAddDialog = false
    @EnvironmentObject var collectionDatas: collectionData
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
                VStack(){
                    ForEach((1...10),id: \.self){num in
                        NavigationLink(destination: armyDetailedView(id: num).onAppear(perform:{ Haptics.shared.play(.light)})) {
                            armyView(id: num)
                        }
                        
                    }
                }
            
            }.navigationTitle("Your armies").toolbar {
                ToolbarItemGroup(placement: .primaryAction){
                    Button(action: {
                        self.showAddDialog.toggle()
                    }) {
                        Label("Add",systemImage:"plus.app")}.sheet(isPresented:$showAddDialog){
                            addArmyDialog().environmentObject(collectionDatas)
                        }

                    }
            }.toolbar{
                ToolbarItemGroup(placement: .navigationBarLeading){
                    Button(action:{
                        self.showAppSettings.toggle()
                        
                    }) {
                        Label("Settings",systemImage:"gear")
                    }.sheet(isPresented:$showAppSettings){
                        appSettings().environmentObject(collectionDatas)
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
