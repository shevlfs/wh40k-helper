import SwiftUI

struct modGameView: View {  // View для отображения модификации в "режиме игры"
  @State var id = Int()
  @State var mod: modification
  var body: some View {
    HStack {
      HStack {
        HStack(alignment: .center, spacing: nil) {
          Group {
            Text("\(mod.range)").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
              maxWidth: 80, alignment: .center
            ).lineLimit(1).minimumScaleFactor(0.01)
            Text("\(mod.type)").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
              maxWidth: 120, alignment: .center
            ).lineLimit(1).minimumScaleFactor(0.01)
            Text("\(mod.s)").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
              maxWidth: 60, alignment: .center
            ).lineLimit(1).minimumScaleFactor(0.01)
            Text("\(mod.ap)").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
              maxWidth: 60, alignment: .center
            ).lineLimit(1).minimumScaleFactor(0.01)
            Text("\(mod.d)").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
              maxWidth: 60, alignment: .center
            ).lineLimit(1).minimumScaleFactor(0.01)

          }.padding()
        }.background(RoundedRectangle(cornerRadius: 10).fill(.mint)).padding()
      }
      Spacer()
      Text("\(mod.name)").fontWeight(.bold).multilineTextAlignment(.trailing).foregroundColor(
        .black
      )
      .font(.title2).frame(maxWidth: 120, alignment: .trailing).lineLimit(3).scaledToFit()
      .minimumScaleFactor(0.01)
    }
  }
}
