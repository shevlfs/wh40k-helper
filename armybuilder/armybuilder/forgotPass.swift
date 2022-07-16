//
//  forgotPass.swift
//  armybuilder
//
//  Created by ted on 7/16/22.
//

import SwiftUI

struct forgotPass: View {
    @State var login = String()
    @State var emailError = false
    @State var success = false
    var body: some View {
        NavigationView{
            VStack{
                Text("Email is incorrect.").foregroundColor(.red).fontWeight(.semibold).opacity(!emailError ? 0 : 1)
                Text("If there is an account associated with this email you will recieve a message with further instructions to reset your password.").foregroundColor(.red).fontWeight(.semibold).opacity(!emailError ? 0 : 1)
                HStack{
                    Text("Email").fontWeight(.semibold).font(.title3)
                    Spacer()
                TextField("", text: $login).padding().foregroundColor(.black)
                        .frame(maxWidth: 195,maxHeight: 10)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color(UIColor.systemGray6)))
                }.padding()
                HStack{
                    Button(action:{
                        emailError = false
                        success = false
                        if(!isValidEmail(login)){
                            emailError = true
                        } else {
                            success = true
                            forgotPassword(email : login)
                        }
                    }){
                        Text("confirm")
                    }
                }
                Spacer()
            }
        }.navigationTitle("Forgot password")
    }
}

struct forgotPass_Previews: PreviewProvider {
    static var previews: some View {
        forgotPass()
    }
}
