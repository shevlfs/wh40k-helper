
import SwiftUI

struct addArmyDialog: View {
    @State var factionSelected = false
    @StateObject var pointTargetd = pointTarget()
    @EnvironmentObject var collectionDatas: collectionData
    @EnvironmentObject var armyControl: armyController
    @State var showNextStep = false
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
        VStack(alignment: .center){
        VStack(alignment: .leading){
            HStack(){
                    Text("Select your faction ").fontWeight(.regular).padding([.leading, .bottom, .trailing]).font(.title3)
                
            }

            Spacer()
        }.navigationTitle("Add a new army!").padding(.top).frame(width: 400, height: 50, alignment: .center)
            VStack(alignment: .center){
                ForEach(factions){faction in
                    NavigationLink(destination: selectTroops(factionfile: faction.id, collectionShowcase: collectionDatas.emptyChecker(factionID: faction.id)).environmentObject(pointTargetd).environmentObject(collectionDatas).environmentObject(armyControl).onTapGesture(perform:{
                        let newarmyid = armyControl.armies.count+1
                        armyControl.armies.append(Army(factionID: faction.id, armyid: newarmyid))
                        showNextStep = false
                    }
                                                                                                                                                                                                                                                                             )){
                        ZStack(){
                            Rectangle().fill(Color(UIColor.systemGray4)).frame(width: 370.0, height: 55.0).cornerRadius(10).padding(.all,10.0)
                            Text(faction.name)
                                .font(.headline)
                            .foregroundColor(Color.black)}
                    }
                }
                        
            }
                Spacer()
                
            }
        }
        }.navigationTitle("Add a new army!")
    }
}

/*struct addArmyDialog_Previews: PreviewProvider {
    static var previews: some View {
        addArmyDialog()
    }
}*/
