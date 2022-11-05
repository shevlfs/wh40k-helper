//
//  accountSettings.swift
//  armybuilder
//
//  Created by ted on 6/13/22.
//

import SwiftUI

struct accountSettings: View {
  @EnvironmentObject var reloadControl: reloadController
  @EnvironmentObject var armyControl: armyController
  @EnvironmentObject var collectionDatas: collectionData
  @Environment(\.dismiss) var dismiss
  @State var loggedout: Bool? = nil
  var body: some View {
    VStack {
      HStack {
          Text("\(reloadControl.currentUser)").font(.largeTitle).fontWeight(.semibold).lineLimit(1).minimumScaleFactor(0.01).scaledToFit()
        Spacer()
      }.padding()
      VStack {
        Button(action: {
          logout()
          reloadControl.showLoginScreen = true
          reloadControl.logOutPerformed = true
          dismiss()
        }) {
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
      }.background(RoundedRectangle(cornerRadius: 12).fill(Color(UIColor.systemGray6))).frame(
        maxWidth: 405
      ).padding()
      Spacer()

    }
  }
}

struct accountSettings_Previews: PreviewProvider {
  static var previews: some View {
    accountSettings()
  }
}
