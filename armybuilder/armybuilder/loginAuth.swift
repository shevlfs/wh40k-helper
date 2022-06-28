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
    @State var gradient = [Color.indigo, Color.mint, Color.green]
    @State var startPoint = UnitPoint(x: 0, y: 0)
    @State var endPoint = UnitPoint(x: 0, y: 2)
    
    @State var Auth: Bool? = nil
    
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
            TextField("", text: $login).padding().foregroundColor(.white)
                .frame(width: 170, height: 10)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(UIColor.systemGray5)))
            }.padding()
            HStack{
                Text("Password").fontWeight(.semibold).font(.title3)
                Spacer()
            TextField("", text: $pass).padding().foregroundColor(.white)
                .frame(width: 170, height: 10)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(UIColor.systemGray5)))
            }.padding()
                
                NavigationLink(destination: ContentView().environmentObject(collectionDatas).environmentObject(armyControl).navigationBarBackButtonHidden(true), tag: true, selection: $Auth){
                    EmptyView()
                }
                
                
                Button(action: {
                    
                    self.Auth = true
                    
                }){
                HStack{
                    Text("Login").padding(.horizontal).padding(.vertical, 10).foregroundColor(.white)
                }.background(RoundedRectangle(cornerRadius: 15).fill(.blue))
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
