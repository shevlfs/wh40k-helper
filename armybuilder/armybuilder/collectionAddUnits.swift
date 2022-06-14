import SwiftUI

struct collectionAddUnits: View {
    @State var factionfile = Int()
    var body: some View {
            ScrollView(.vertical){
                HStack(){
                        Text("Select units for your colleciton ").fontWeight(.regular).padding([.leading, .bottom, .trailing],14).font(.title3)
                }
            VStack(alignment: .center){
                ForEach(globalstats[factionfile].units){unit in
                    ZStack(){
                        collectionSelection(unitcount: 0, unitname: unit.name)
                    }
                }
                }.navigationTitle("Add units to collection")
            }
        }
        
}

struct collectionAddUnits_Previews: PreviewProvider {
    static var previews: some View {
        collectionAddUnits()
    }
}
