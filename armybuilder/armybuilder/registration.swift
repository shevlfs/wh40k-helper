//
//  registration.swift
//  armybuilder
//
//  Created by ted on 6/29/22.
//

import SwiftUI

struct registration: View { // View с экраном регистрации
  @State var userEmail = String()
  @State var userPass = String()
  @State var passConfirmation = String()
  @Environment(\.presentationMode) var presentationMode
  @State var passConfirmationError = false
  @State var passEmptyError = false
  @State var passCaseError = false
  @State var passLengthError = false
  @State var emailInvalidError = false
  var body: some View {
    NavigationView {
      VStack {
        if passConfirmationError == true {
          Text("Passwords do not match.").font(.title2).foregroundColor(.red)
        } else if passEmptyError == true {
          Text("Password cannot be empty.").font(.title2).foregroundColor(.red)
        } else if passCaseError == true {
          Text("Password must have lower and upper case symbols.").font(.title2).foregroundColor(
            .red)
        } else if emailInvalidError == true {
          Text("Login is not a valid email.").font(.title2).foregroundColor(.red)
        } else if passLengthError == true {
          Text("Password is too short.").font(.title2).foregroundColor(.red)
        }
        HStack {
          Text("Email").fontWeight(.semibold).font(.title3)
          Spacer()
          TextField("", text: $userEmail).padding().foregroundColor(.black)
            .frame(maxWidth: 195, maxHeight: 10)
            .padding()
            .background(
              RoundedRectangle(cornerRadius: 8)
                .fill(Color(UIColor.systemGray6)))
        }.padding()
        HStack {
          Text("Password").fontWeight(.semibold).font(.title3)
          Spacer()
          SecureField("", text: $userPass).padding().foregroundColor(.black)
            .frame(maxWidth: 195, maxHeight: 10)
            .padding()
            .background(
              RoundedRectangle(cornerRadius: 8)
                .fill(Color(UIColor.systemGray6)))
        }.padding()
        HStack {
          Text("Confirm password").fontWeight(.semibold).font(.title3).frame(maxWidth: 90)
          Spacer()
          SecureField("", text: $passConfirmation).padding().foregroundColor(.black)
            .frame(maxWidth: 195, maxHeight: 10)
            .padding()
            .background(
              RoundedRectangle(cornerRadius: 8)
                .fill(Color(UIColor.systemGray6)))
        }.padding()
        HStack {
          Button(action: {
            passEmptyError = false
            passConfirmationError = false
            passCaseError = false
            emailInvalidError = false
            passLengthError = false
            if !userPass.isEmpty == false {
              passEmptyError = true
            } else if userPass != passConfirmation {
              passConfirmationError = true
            } else if !(userPass.count >= 7) {
              passLengthError = true
            } else if userPass == passConfirmation.lowercased() {
              passCaseError = true
            } else if !isValidEmail(userEmail) {
              emailInvalidError = true
            } else {
              register(name: userEmail, password: userPass)
              presentationMode.wrappedValue.dismiss()
            }
          }) {
            HStack {
              Text("Confirm").padding(.horizontal, 27).padding(.vertical, 12).foregroundColor(
                .white)
            }.background(RoundedRectangle(cornerRadius: 10).fill(.blue)).padding()
          }
        }
        Spacer()
      }.padding().navigationTitle("Registration")
    }
  }
}
