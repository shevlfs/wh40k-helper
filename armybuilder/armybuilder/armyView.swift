//
//  armyView.swift
//  armybuilder
//
//  Created by ted on 21.02.2022.
//

import SwiftUI

struct armyView: View {
    @StateObject var army = Army()
    @State var id = Int()
    @State var faction = String()
    
        var body: some View {
            VStack {
                Group {
                        VStack(alignment: .center,spacing: 4) {
                            HStack {
                                Spacer()
                                Text("Army \(id)")
                                    .font(.title)
                                    .foregroundColor(.white)
                                .bold()
                                Spacer()
                            }
                            HStack {
                                Text("\(army.points) pts")
                                Rectangle()
                                    .frame(width: 0.5, height: 20)
                                HStack(spacing: 6) {
                                    Image(systemName: "bolt.horizontal.fill")
                                    Text("Faction")
                                }
                            }.foregroundColor(.white)
                        }
                        .padding(.vertical, 48)
                        .background(RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .fill(Color(UIColor.systemGreen))
                        
                        )
                        .background(RoundedRectangle(cornerRadius: 20, style: .continuous)
                                        .fill(Color(UIColor.systemGreen))
                                        .blur(radius: 10)
                        
                        )
                    .padding(32)
                    }
                    .buttonStyle(ScaleableButtonStyle())
            }
        }
    }

struct ScaleableButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .scaleEffect(configuration.isPressed ? 0.98 : 1)
            .animation(.interactiveSpring(), value: configuration.isPressed)
    }
}

struct armyView_Previews: PreviewProvider {
    static var previews: some View {
        armyView()
    }
}
