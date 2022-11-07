import SwiftUI

struct modDisplay: View {  // View отображающий модификацию при добавлении её к юниту
  @State var mod: mod
  var body: some View {
    VStack {
      HStack {
        Text("\(mod.name)").font(.title).fontWeight(.semibold).foregroundColor(.white)
        Spacer()
      }.padding()
      HStack {
        VStack {
          Text("Range").font(.title2).fontWeight(.semibold).foregroundColor(.white).padding(3)
          Text("\(mod.range)").font(.title2).fontWeight(.bold).foregroundColor(.white).padding(3)
        }.padding(3)
        VStack {
          Text("Type").font(.title2).fontWeight(.semibold).foregroundColor(.white).padding(3)
          Text("\(mod.type)").font(.title2).fontWeight(.bold).foregroundColor(.white).padding(3)

        }.padding(3)
        VStack {
          Text("S").font(.title2).fontWeight(.semibold).foregroundColor(.white).padding(3)
          Text("\(mod.s)").font(.title2).fontWeight(.bold).foregroundColor(.white).padding(3)

        }.padding(3)
        VStack {
          Text("AP").font(.title2).fontWeight(.semibold).foregroundColor(.white).padding(3)
          Text("\(mod.ap)").font(.title2).fontWeight(.bold).foregroundColor(.white).padding(3)

        }.padding(3)
        VStack {
          Text("D").font(.title2).fontWeight(.semibold).foregroundColor(.white).padding(3)
          Text("\(mod.d)").font(.title2).fontWeight(.bold).foregroundColor(.white).padding(3)

        }.padding(3)

      }.padding()

    }.background(RoundedRectangle(cornerRadius: 15).fill(.mint)).padding()
  }
}
