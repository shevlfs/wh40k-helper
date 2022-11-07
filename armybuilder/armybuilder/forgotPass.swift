import SwiftUI

struct forgotPass: View { // View с меню восстановления пароля
  @State var login = String()
  @State var emailError = false
  @State var success = false
  var body: some View {
    NavigationView {
      VStack {
        Text("Email is incorrect.").foregroundColor(.red).fontWeight(.semibold).opacity(
          !emailError ? 0 : 1)
        Text(
          "If there is an account associated with this email you will recieve a message with further instructions to reset your password."
        ).foregroundColor(.red).fontWeight(.semibold).multilineTextAlignment(.center).opacity(
          !success ? 0 : 1
        ).padding()
        HStack {
          Spacer()
          TextField("Email", text: $login).padding().foregroundColor(.black)
            .frame(maxHeight: 20)
            .padding()
            .background(
              RoundedRectangle(cornerRadius: 8)
                .fill(Color(UIColor.systemGray6)))
        }.padding()
        HStack {
          Button(action: {
            emailError = false
            success = false
            if !isValidEmail(login) {
              emailError = true
            } else {
              success = true
              forgotPassword(email: login)
            }
          }) {
              HStack{
                  Text("Confirm").padding(.horizontal, 27).padding(.vertical, 12).foregroundColor(
                    .white)}.background(RoundedRectangle(cornerRadius: 10).fill(.blue)).padding()
          }
        }
        Spacer()
      }.navigationBarTitle("Forgot password")
    }
  }
}
