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
    
    @StateObject var collectionDatas = collectionData()
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
                
                NavigationLink(destination: ContentView().environmentObject(collectionDatas).environmentObject(armyControl).navigationBarBackButtonHidden(true), tag: true, selection: $Auth){
                    EmptyView()
                }
                
                
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
                            
                            self.Auth = true
                            
                        }){
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
