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
    @State var caseError = false
    @State var invalidEmail = false
    @State var shortPass = false
    var body: some View {
        NavigationView{
        VStack{
            if (passConfError == true){
                Text("Passwords do not match.").font(.title2).foregroundColor(.red)
            } else if (emptyPass == true) {
                Text("Password cannot be empty.").font(.title2).foregroundColor(.red)
            } else if (caseError == true){
                Text("Password must have lower and upper case symbols.").font(.title2).foregroundColor(.red)
            } else if (invalidEmail == true){
                Text("Login is not a valid email.").font(.title2).foregroundColor(.red)
            } else if (shortPass == true){
                Text("Password is too short.").font(.title2).foregroundColor(.red)
            }
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
                Text("Confirm password").fontWeight(.semibold).font(.title3).frame(maxWidth: 90)
                Spacer()
            SecureField("", text: $passConf).padding().foregroundColor(.black)
                .frame(maxWidth: 195, maxHeight: 10)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color(UIColor.systemGray6)))
            }.padding()
            HStack{
                Button(action: {
                    emptyPass = false
                    passConfError = false
                    caseError = false
                    invalidEmail = false
                    shortPass = false
                    if (!pass.isEmpty == false){
                        emptyPass = true
                    } else if(pass != passConf){
                        passConfError = true
                    } else if(pass == passConf.lowercased()){
                        caseError = true
                    } else if(!(pass.count >= 7)){
                        shortPass = true
                    }
                        else if(!isValidEmail(login)){
                        invalidEmail = true
                    }
                    else {
                        register(name: login, password: pass)
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
