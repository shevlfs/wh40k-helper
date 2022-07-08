//
//  loginAuth.swift
//  armybuilder
//
//  Created by ted on 6/29/22.
//

import SwiftUI

struct loginAuth: View {
    @State var login = String()
    @State var pass = String()
    
    
    @State var Auth: Bool? = nil
    @State var showRegistration = false
    @State var wrongPass = false
    @State var emptyPass = false
    @StateObject var collectionDatas = collectionData()
    @EnvironmentObject var reloadControl : reloadController
    @StateObject var armyControl = armyController()
    var body: some View {
        NavigationView{
        VStack{
            ZStack{
                rectangleLogo()
                Text("ArmyBuilder").foregroundColor(.white).font(.title).fontWeight(.bold).padding()
            }.padding()
            VStack{
            HStack{
                Text("Email").fontWeight(.semibold).font(.title3)
                Spacer()
            TextField("", text: $login).padding().foregroundColor(.black)
                .frame(width: 170, height: 10)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(UIColor.systemGray5)))
            }.padding()
            HStack{
                Text("Password").fontWeight(.semibold).font(.title3)
                Spacer()
            SecureField("", text: $pass).padding().foregroundColor(.black)
                .frame(width: 170, height: 10)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(UIColor.systemGray5)))
            }.padding()
                if (Auth == true){
                    if (reloadControl.reloadNeeded == true){
                    NavigationLink(destination: ContentView().environmentObject(fillcollectiondata(collectionDatas: collectionDatas)).environmentObject(filledarmycontrol).environmentObject(reloadControl).onAppear(perform: {reloadControl.reloadNeeded = false}).navigationBarBackButtonHidden(true), tag: true, selection: $Auth){
                    EmptyView()
                }
                    } else {
                        NavigationLink(destination: ContentView().environmentObject(collectionDatas).environmentObject(armyControl).environmentObject(reloadControl).onAppear(perform: {reloadControl.reloadNeeded = false}).navigationBarBackButtonHidden(true), tag: true, selection: $Auth){
                        EmptyView()
                    }
                        
                    }
                }
                
                Text("Wrong name or password.").foregroundColor(.red).fontWeight(.semibold).opacity(!wrongPass ? 0 : 1)
                
                
                    HStack{
                        Button(action: {
                            self.showRegistration.toggle()
                        }){
                        HStack{
                            Text("Register").padding(.horizontal, 27).padding(.vertical, 12).foregroundColor(.white)
                        }.background(RoundedRectangle(cornerRadius: 10).fill(.blue)).padding()}.sheet(isPresented: $showRegistration){
                            registration()
                        }
                        Button(action: {
                            if (login.isEmpty || pass.isEmpty){
                                wrongPass = true
                            } else {
                                let result = armybuilder.login(name: login, password: pass)
                               if (result == "logged in successfully" ){
                                   reloadControl.reloadNeeded = true
                                   self.Auth = true
                                }
        
                            else {
                                wrongPass = true
                            }
                            }}){
                        HStack{
                            Text("Login").padding(.horizontal,27).padding(.vertical, 12).foregroundColor(.white)
                        }.background(RoundedRectangle(cornerRadius: 10).fill(.blue)).padding()
                    }
                }.padding()
            }.padding()
            Spacer()
        }
        }.navigationViewStyle(.stack)
    }
    var filledarmycontrol: armyController {
        let group = DispatchGroup()
                group.enter()
                DispatchQueue.main.async {
                    let tempArmyList = getArmyControl()
                    armyControl.armies = [Army]()
                    for tempArmy in tempArmyList{
                    var mappedDict = [Int:Int]()
                    var done = false
                    let mappedKeys = tempArmy.troops.map {Int( $0.key)}
                    let zippedArray = Array((zip(mappedKeys, tempArmy.troops.map{$0.value})))
                    for element in zippedArray {
                        mappedDict[element.0!] = element.1
                    }
                    var army = Army(factionID: tempArmy.factionid, armyid: tempArmy.armyid)
                        
                        var tempmods: [Int : [modification]] = [:]
                        for unit in tempArmy.mods.keys{
                            let intkey = Int(unit)
                            tempmods[intkey!] = [modification]()
                            if (!tempArmy.mods[unit]!.isEmpty){
                                for mod in tempArmy.mods[unit]!{
                                    tempmods[intkey!]!.append(modification(name: mod.name, range: mod.range, type: mod.type, s: mod.s, ap: mod.ap, d: mod.d, pts: mod.pts, count: mod.count))
                                }
                            }
                        }
                        
                        army.custinit(name: tempArmy.name, armyid: armyControl.armies.count + 1, factionID: tempArmy.factionid
                                  , pointCount: tempArmy.pointCount, troops: mappedDict, mods: tempmods, deleted: false)
                        
                        
                    armyControl.armies.append(army)
                        print(army.name ,army.pointCount)
                    }
                    group.leave()
                }
                
                group.notify(queue: .main) {
                    print("Simulation finished")
                }
        reloadControl.reloadNeeded = false
        return armyControl
    }
}

struct loginAuth_Previews: PreviewProvider {
    static var previews: some View {
        loginAuth()
    }
}
