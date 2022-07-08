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
    var body: some View {
        VStack{
            VStack{
            Button(action:{
                logout()
                reloadControl.loggedIn = false
            }){
                VStack(alignment: .trailing) {
                    HStack {
                        Image(systemName: "person.fill")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                        .clipped().padding(.horizontal)

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
            }.foregroundColor(.red)
            }.background(RoundedRectangle(cornerRadius: 12).fill(Color(UIColor.systemGray6))).frame(maxWidth: 405).padding()
            
        }.navigationTitle("\(account)")
    }
}

struct accountSettings_Previews: PreviewProvider {
    static var previews: some View {
        accountSettings(account : "test")
    }
}
