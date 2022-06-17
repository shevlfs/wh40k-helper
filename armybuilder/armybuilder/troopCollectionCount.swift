import SwiftUI

struct troopCollectionCount: View {
    @State var unitcount: Int
    @State var unitname = String()
    @State var pointcount = Int()
    @EnvironmentObject var pointTarget: pointTarget
    var body: some View {
        VStack(alignment: .trailing) {
            Text(unitname)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.green)
                )
            pickerView()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(Color(UIColor.systemGray6)))
    }
}

extension troopCollectionCount {
    @ViewBuilder
    private func pickerView() -> some View {
        HStack {
            Text("\(pointcount) pts").foregroundColor(.white)
                .padding(.vertical, 8).padding(.horizontal, 40)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.green)
                )
            Spacer()
            Button(action: {
                if (unitcount != 0){
                    unitcount -= 1
                    pointTarget.currentPoints -= pointcount
                }
            }) {
                Text("-")
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(RoundedRectangle(cornerRadius: 5).fill(.green))
            }
            Text("\(unitcount)")
            Button(action: {
                unitcount = unitcount + 1
                pointTarget.currentPoints += pointcount
            }) {
                Text("+")
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(RoundedRectangle(cornerRadius: 5).fill(.green))
            }
        }
    }
}

/* struct troopCollectionCount_Previews: PreviewProvider {
    static var previews: some View {
        troopCountSelect(unitcount: 0, unitname: "", pointcount: 150)
    }
} */

