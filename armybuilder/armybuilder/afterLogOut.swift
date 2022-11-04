//
//  loginAuth.swift
//  armybuilder
//
//  Created by ted on 6/29/22.
//

import SwiftUI

struct afterLogOut: View { // View с экраном авторизации (после выхода из аккаунта)
    @State var login = String()
    @State var pass = String()
    
    @State var showForgotprompt = false
    @State var Auth: Bool? = nil
    @State var showRegistration = false
    @State var wrongPass = false
    @State var emptyPass = false
    @State var notVerified = false
    @StateObject var collectionDatas = collectionData()
    @EnvironmentObject var reloadControl : reloadController
    @StateObject var armyControl = armyController()
    var body: some View {
        VStack{
            Spacer()
            ZStack{
                rectangleLogo()
                Text("ArmyBuilder").foregroundColor(.white).font(.title).fontWeight(.bold).padding()
            }.padding()
            VStack{
            HStack{
                Text("Email").fontWeight(.semibold).font(.title3)
                Spacer()
            TextField("", text: $login).padding().foregroundColor(.black)
                .frame(maxWidth: 195, maxHeight: 10)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(UIColor.systemGray6)))
            }.padding()
            HStack{
                Text("Password").fontWeight(.semibold).font(.title3)
                Spacer()
            SecureField("", text: $pass).padding().foregroundColor(.black)
                .frame(maxWidth: 195, maxHeight: 10)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(UIColor.systemGray6)))
            }.padding()
                HStack{
                    Button(action: {
                        showForgotprompt.toggle()
                    }){
                        Text("Forgot password...").padding()
                    }.sheet(isPresented: $showForgotprompt, content: {forgotPass()})
                    Spacer()
                }
                
                
                
                if (Auth == true){
                    if (reloadControl.reloadNeeded == true && reloadControl.logOutPerformed == true){
                        NavigationLink(destination: ContentView().onAppear(perform: {reloadControl.logOutPerformed = false}).environmentObject(fillCollectionInfo(collectionDatas: collectionDatas)).environmentObject(filledarmycontrol).environmentObject(reloadControl).navigationBarBackButtonHidden(true), tag: true, selection: $Auth){
                    EmptyView()
                }
                    } else {
                        NavigationLink(destination: ContentView().environmentObject(collectionDatas).environmentObject(armyControl).environmentObject(reloadControl).onAppear(perform: {reloadControl.reloadNeeded = false}).navigationBarBackButtonHidden(true), tag: true, selection: $Auth){
                        EmptyView()
                    }
                        
                    }
                }
                
                Text("Wrong name or password.").foregroundColor(.red).fontWeight(.semibold).opacity(!wrongPass ? 0 : 1)
        
                Text("Please verify your email by checking your inbox for a message from ArmyBuilder.").foregroundColor(.red).fontWeight(.semibold).opacity(!notVerified ? 0 : 1)
                
                
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
                            wrongPass = false
                            notVerified = false
                            if (login.isEmpty || pass.isEmpty){
                                wrongPass = true
                            } else {
                                let result = armybuilder.login(name: login, password: pass)
                               if (result == "logged in successfully" ){
                                   reloadControl.reloadNeeded = true
                                   self.Auth = true
                               } else if (result == "verify your account"){
                                   self.notVerified = true
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
    }
    var filledarmycontrol: armyController {
        let group = DispatchGroup()
        let internalQueue = DispatchQueue(label: "InternalQueue")
                group.enter()
        internalQueue.async
         {
                DispatchQueue.main.sync {
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
                    print("Data Loaded")
                }
         }
        reloadControl.reloadNeeded = false
        return armyControl
    }
}


