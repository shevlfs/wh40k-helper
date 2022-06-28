//
//  registration.swift
//  armybuilder
//
//  Created by ted on 6/29/22.
//

import SwiftUI

struct registration: View {
    @State var login = String()
    @State var pass = String()
    @State var passConf = String()
    @Environment(\.presentationMode) var presentationMode
    @State var passConfError = false
    @State var emptyPass = false
    var body: some View {
        NavigationView{
        VStack{
            if (passConfError == true){
                Text("Passwords do not match.").font(.title2).foregroundColor(.red)
            } else if (emptyPass == true) {
                Text("Password cannot be empty.").font(.title2).foregroundColor(.red)
            }
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
            SecureField("", text: $pass).padding().foregroundColor(.black)
                .frame(width: 170, height: 10)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(UIColor.systemGray5)))
            }.padding()
            HStack{
                Text("Confirm password").fontWeight(.semibold).font(.title3).frame(maxWidth: 90)
                Spacer()
            SecureField("", text: $passConf).padding().foregroundColor(.black)
                .frame(width: 170, height: 10)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(UIColor.systemGray5)))
            }.padding()
            HStack{
                Button(action: {
                    if (!pass.isEmpty == false){
                        emptyPass = true
                    } else if(pass != passConf){
                        passConfError = true
                    } else {
                        /* register user */
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                }){
                HStack{
                    Text("Confirm").padding(.horizontal,27).padding(.vertical, 12).foregroundColor(.white)
                }.background(RoundedRectangle(cornerRadius: 10).fill(.blue)).padding()
            }
            }
            Spacer()
        }.padding().navigationTitle("Registration")
        }
    }
}

struct registration_Previews: PreviewProvider {
    static var previews: some View {
        registration()
    }
}
