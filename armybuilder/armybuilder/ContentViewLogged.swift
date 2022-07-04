import SwiftUI
import HidingViews

struct ContentViewLogged: View {
    @State var showAppSettings : Bool? = nil
    @State var showAddDialog = false
    @EnvironmentObject var collectionDatas: collectionData
    @EnvironmentObject var armyControl: armyController
    @EnvironmentObject var reloadControl: reloadController
    @State var deleted = false
    
    @StateObject var viewControl = viewController()
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
                VStack(){
                    
                    
                    if (armyControl.armies.isEmpty){
                        Spacer()
                        Text("No armies! :(").fontWeight(.light).padding()
                    } else{
                    ForEach(armyControl.armies){army in
                        if (!army.deleted){
                        NavigationLink(destination: armyDetailedView(id: army.armyid).environmentObject(collectionDatas).environmentObject(armyControl).onAppear(perform: {
                            let value = UIInterfaceOrientation.portrait.rawValue
                            UIDevice.current.setValue(value, forKey: "orientation")}
                                                                                                                                )) {
armyView(id: army.armyid, faction: factions[army.factionID].name).environmentObject(armyControl).environmentObject(collectionDatas).contextMenu{
Button(action:{
                                }){
                                    Text("Delete")}}}.contextMenu{
                            Button(action:{
                                deleteArmy(army: army)
                                armyControl.armies[army.armyid - 1].deleted = true
                                reloadControl.reloadNeeded = true
                            }){
                                Text("Delete")
    }
                                    }
                            
                        }
                        
                    }
                    }
                    NavigationLink(destination: appSettings().environmentObject(collectionDatas).environmentObject(armyControl), tag: true, selection: $showAppSettings){
                        EmptyView()
                    }
                    
                }
            
            }.navigationTitle("Your armies").toolbar {
                ToolbarItemGroup(placement: .primaryAction){
                    Button(action: {
                        viewControl.showingaddArmy = true
                    }) {
                        Label("Add",systemImage:"plus.app")}.sheet(isPresented:$viewControl.showingaddArmy){
                            addArmyDialog().environmentObject(viewControl).environmentObject(collectionDatas).environmentObject(armyControl)
                        }

                    }
            }.toolbar{
                ToolbarItemGroup(placement: .navigationBarLeading){
                    Button(action:{
                        showAppSettings = true
                        
                    }) {
                        Label("Settings",systemImage:"gear")
                    }
                }
            }
        }.navigationViewStyle(.stack)
    }
}
    

/*struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(collectionData()).environmentObject(armyController())
    }
}*/
