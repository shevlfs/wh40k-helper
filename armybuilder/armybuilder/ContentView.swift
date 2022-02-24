import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
                VStack(){
                    armyView()
                    armyView()
                }
            
            }.navigationTitle("Your armies:").toolbar {
                ToolbarItemGroup(placement: .primaryAction) {
            Button() {
                Label("Add",systemImage:"plus.app")
            } label:{}
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
