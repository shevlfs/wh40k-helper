import SwiftUI

struct collectionSelection: View {
    @State var unitcount: Int
    @State var unitname = String()
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

extension collectionSelection {
    @ViewBuilder
    private func pickerView() -> some View {
        HStack {
            Button(action: {
                if (unitcount != 0){
                    unitcount -= 1
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
                unitcount += 1
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

struct collectionSelection_Previews: PreviewProvider {
    static var previews: some View {
        collectionSelection(unitcount: 0, unitname: "")
    }
}

