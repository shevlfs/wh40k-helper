import SwiftUI

struct ContentView: View {
    @State var showAppSettings = false
    @State var showAddDialog = false
    @EnvironmentObject var collectionDatas: collectionData
    @EnvironmentObject var armyControl: armyController
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
                VStack(){
                    
                    
                    if (armyControl.armies.isEmpty){
                        Spacer()
                        Text("No armies! :(").fontWeight(.light).padding()
                    } else{
                    ForEach(armyControl.armies){army in
                        NavigationLink(destination: armyDetailedView(id: army.armyid).onAppear(perform:{ Haptics.shared.play(.light)})) {
                            armyView(id: army.armyid)
                        }
                    }
                    }
                    
                    
                }
            
            }.navigationTitle("Your armies").toolbar {
                ToolbarItemGroup(placement: .primaryAction){
                    Button(action: {
                        self.showAddDialog.toggle()
                    }) {
                        Label("Add",systemImage:"plus.app")}.sheet(isPresented:$showAddDialog){
                            addArmyDialog().environmentObject(collectionDatas).environmentObject(armyControl)
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
        ContentView().environmentObject(collectionData()).environmentObject(armyController())
    }
}
