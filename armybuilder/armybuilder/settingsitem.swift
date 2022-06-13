//
//  settingsitem.swift
//  armybuilder
//
//  Created by ted on 6/11/22.
//

import SwiftUI

struct settingsitem: View {
    @State var icon = String()
    @State var optionname = String()
    var body: some View {
        VStack(alignment: .trailing) {
            HStack {
                Image(systemName: icon)
                                .resizable()
                                .cornerRadius(12)
                                .frame(width: 25, height: 25)
                                .clipped()
                                .aspectRatio(contentMode: .fit).padding(.horizontal)

                            Text(optionname)
                                .foregroundColor(.blue)
                                .font(.system(size: 18))
                Spacer()
                        }
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.white)
                )
        }

    }
}

struct settingsitem_Previews: PreviewProvider {
    static var previews: some View {
        settingsitem(icon: "person.fill", optionname: "Account")
    }
}
