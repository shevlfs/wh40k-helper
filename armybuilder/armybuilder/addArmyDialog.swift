//
//  addArmyDialog.swift
//  armybuilder
//
//  Created by ted on 3/21/22.
//

import SwiftUI
import CoreData

struct addArmyDialog: View {
    @State var factionSelected = false
    @StateObject var viewModel: AddArmyViewModel
    init(_ context: NSManagedObjectContext) {
        self._viewModel = StateObject(wrappedValue: AddArmyViewModel(context: context))
    }
    var body: some View {
        NavigationView{
            ScrollView(.vertical){
        VStack(alignment: .center){
        VStack(alignment: .leading){
            HStack(){
                    Text("Select your faction ").fontWeight(.regular).padding([.leading, .bottom, .trailing],14).font(.title3)
                Spacer()
            }

            Spacer()
        }.navigationTitle("Add a new army!").padding(.top).frame(width: 400, height: 50, alignment: .center)
            VStack(alignment: .center){
                ForEach(factions){faction in
                    NavigationLink(destination: selectTroops(factionID: faction.id).environmentObject(viewModel)){
                            Text(faction.name)
                                .font(.headline)
                            .foregroundColor(Color.black)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(.gray))
                            .padding([.top, .horizontal])
                        
                    } 
                    
                }
                        
            }
                Spacer()
                
            }
        }
        }.navigationTitle("Add a new army!")
    }
}

struct addArmyDialog_Previews: PreviewProvider {
    static var previews: some View {
        addArmyDialog(DataController().container.viewContext)
    }
}

// делать {
//    попытаться! думать()
// } совершить_ошибку {
//    не_бояться()
//    учиться(ошибка: ошибка)
//    возвратить()
// }
