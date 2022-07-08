//
//  accountSettings.swift
//  armybuilder
//
//  Created by ted on 6/13/22.
//

import SwiftUI

struct accountSettings: View {
    @State var account: String
    @EnvironmentObject var reloadControl: reloadController
    @EnvironmentObject var armyControl: armyController
    @EnvironmentObject var collectionDatas: collectionData
    
    @State var loggedout: Bool? = nil
    
    var body: some View {
        VStack{
            VStack{
                NavigationLink(destination: afterLogOut().navigationBarBackButtonHidden(true).environmentObject(reloadControl).environmentObject(collectionDatas).environmentObject(armyControl), tag: true, selection: $loggedout){
                    EmptyView()
                }
            Button(action:{
                logout()
                reloadControl.loggedIn = false
                reloadControl.reloadNeeded = true
                reloadControl.logOutPerformed = true
                self.loggedout = true
            }){
                VStack(alignment: .trailing) {
                    HStack {
                        Image(systemName: "person.fill")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .clipped().foregroundColor(.red).padding(.horizontal)

                                    Text("Log out")
                            .foregroundColor(.red)
                                        .font(.system(size: 18))
                        Spacer()
                                }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(.white)
                        )
                }.padding()
            }
            }.background(RoundedRectangle(cornerRadius: 12).fill(Color(UIColor.systemGray6))).frame(maxWidth: 405).padding()
            Spacer()
            
        }.navigationTitle("\(account)")
    }
}

struct accountSettings_Previews: PreviewProvider {
    static var previews: some View {
        accountSettings(account : "test")
    }
}
