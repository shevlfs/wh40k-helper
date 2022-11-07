import SwiftUI

struct tableUnitHeader: View { // View с "заголовком" таблицы статистик модификаций юнита в "режиме игры" при отображении модификаций юнита
  @State var name = String()
  var body: some View {
    HStack {
      HStack {
        HStack(alignment: .center, spacing: nil) {
          Group {
              Text("Range").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
              maxWidth: 80, alignment: .center).lineLimit(1).minimumScaleFactor(0.01)
            Text("Type").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
              maxWidth: 120, alignment: .center).lineLimit(1).minimumScaleFactor(0.01)
            Text("S").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
              maxWidth: 60, alignment: .center).lineLimit(1).minimumScaleFactor(0.01)
            Text("AP").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
              maxWidth: 60, alignment: .center).lineLimit(1).minimumScaleFactor(0.01)
            Text("D").font(.title2).fontWeight(.bold).foregroundColor(.white).frame(
              maxWidth: 60, alignment: .center).lineLimit(1).minimumScaleFactor(0.01)

          }.padding()
        }.background(RoundedRectangle(cornerRadius: 10).fill(.mint)).padding()
      }
      Spacer()
        Text("\(name)").fontWeight(.bold).multilineTextAlignment(.trailing).foregroundColor(.black)
            .font(.title2).frame(maxWidth: 120, alignment: .trailing).lineLimit(3).scaledToFit().minimumScaleFactor(0.01)

    }
  }
}
