//
//  accountSettings.swift
//  armybuilder
//
//  Created by ted on 6/13/22.
//

import SwiftUI

struct accountSettings: View {
    @State var account: String
    var body: some View {
        VStack{
            
        }.navigationTitle("\(account)")
    }
}

struct accountSettings_Previews: PreviewProvider {
    static var previews: some View {
        accountSettings(account : "test")
    }
}
