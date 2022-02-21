import SwiftUI

struct ContentView: View {
    var body: some View {
        ScrollView(.vertical){
            VStack(){
                armyView()
                armyView()
            }
        }
    }
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
