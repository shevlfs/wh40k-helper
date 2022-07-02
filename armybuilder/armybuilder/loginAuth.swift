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
    @StateObject var armyControl: armyController = load("armyControl.json")
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
                
                NavigationLink(destination: ContentView().environmentObject(collectionDatas).environmentObject(armyControl).navigationBarBackButtonHidden(true), tag: true, selection: $Auth){
                    EmptyView()
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
                                   let tempArmy = getArmyControl()
                                   var mappedDict = [Int:Int]()
                                   let mappedKeys = tempArmy.troops.map {Int( $0.key)}
                                   let zippedArray = Array((zip(mappedKeys, tempArmy.troops.map{$0.value})))
                                   for element in zippedArray {
                                       mappedDict[element.0!] = element.1
                                   }
                                   var army = Army(factionID: tempArmy.factionid, armyid: tempArmy.armyid)
                                   army.custinit(name: tempArmy.name, armyid: tempArmy.armyid, factionID: tempArmy.factionid
                                                 , pointCount: tempArmy.pointCount, troops: mappedDict)
                                   armyControl.armies.append(army)
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
}

struct loginAuth_Previews: PreviewProvider {
    static var previews: some View {
        loginAuth()
    }
}
