import SwiftUI

struct loginAuth: View {  // View с экраном авторизации
  @State var userEmail = String()
  @State var userPass = String()
  @State var showForgotprompt = false
  @State var showRegistration = false
  @State var wrongPass = false
  @State var notVerified = false
  @EnvironmentObject var collectionDatas: collectionData
  @EnvironmentObject var reloadControl: reloadController
  @EnvironmentObject var armyControl: armyController
  var body: some View {
    NavigationView {
      VStack {
        Spacer()
        ZStack {
          rectangleLogo()  // анимированный логотип
          Text("ArmyBuilder").foregroundColor(.white).font(.title).fontWeight(.bold).padding()
        }.padding()
        VStack {
          HStack {
            TextField("Email", text: $userEmail).padding().foregroundColor(.black).frame(maxHeight: 20)
              .padding()
              .background(
                RoundedRectangle(cornerRadius: 8)
                  .fill(Color(UIColor.systemGray6)))
          }.padding()
          HStack {
              SecureField("Password", text: $userPass).padding().foregroundColor(.black).frame(maxHeight: 20)
              .padding()
              .background(
                RoundedRectangle(cornerRadius: 8)
                  .fill(Color(UIColor.systemGray6)))
          }.padding()
          HStack {
            Button(action: {
              showForgotprompt.toggle()  // экран "забыли пароль"
            }) {
              Text("Forgot password...").padding()
            }.sheet(isPresented: $showForgotprompt, content: { forgotPass() })
            Spacer()
          }
          Text("Wrong name or password.").foregroundColor(.red).fontWeight(.semibold).opacity(
            !wrongPass ? 0 : 1)
          Text("Please verify your email by checking your inbox for a message from ArmyBuilder.")
            .foregroundColor(.red).fontWeight(.semibold).opacity(!notVerified ? 0 : 1)
          HStack {
            Button(action: {
              self.showRegistration.toggle()
            }) {
              HStack {
                Text("Register").padding(.horizontal, 27).padding(.vertical, 12).foregroundColor(
                  .white)
              }.background(RoundedRectangle(cornerRadius: 10).fill(.blue)).padding()
            }.sheet(isPresented: $showRegistration) {
              registration()  // вызов меню регистрации
            }
            Button(action: {
              wrongPass = false
              notVerified = false
              if userEmail.isEmpty || userPass.isEmpty {
                wrongPass = true
              } else {
                let result = armybuilder.login(name: userEmail, password: userPass)
                if result == "logged in successfully" {
                  reloadControl.currentUser = whoami()
                  armyControl.armies = fillArmyControlInfo(armyControl: armyControl).armies
                  collectionDatas.collectionDict =
                    fillCollectionInfo(collectionDatas: collectionDatas).collectionDict
                  reloadControl.logOutPerformed = false
                  reloadControl.showLoginScreen = false
                } else if result == "verify your account" {
                  self.notVerified = true
                } else {
                  wrongPass = true
                }
              }
            }) {
              HStack {
                Text("Login").padding(.horizontal, 27).padding(.vertical, 12).foregroundColor(
                  .white)
              }.background(RoundedRectangle(cornerRadius: 10).fill(.blue)).padding()
            }
          }.padding()
        }.padding()
        Spacer()
      }
    }.navigationViewStyle(.stack)
  }
}
