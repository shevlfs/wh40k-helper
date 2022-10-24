//
//  selectTroops.swift
//  armybuilder
//
//  Created by ted on 3/23/22.
//

import SwiftUI


class pointTarget: ObservableObject{ // объект для хранения цели по очкам
    @Published var count = 0
    @Published var targetpointbool = false
    @Published var currentPoints = 0
}


struct selectTroops: View {
    @State var factionfile = Int()
    @State var currentpoints = Int()
    @State var targetMenu = false
    @State var targetPopUp = false
    @EnvironmentObject var pointTarget: pointTarget
    @EnvironmentObject var collectionDatas: collectionData
    @EnvironmentObject var armyControl: armyController
    @EnvironmentObject var viewControl: viewController
    @State var searchText = String()
    @State var collectionShowcase: Bool
    @State var collectionHidden = false
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationLink(destination: EmptyView()) {
            EmptyView() // фикс бага swiftui...
        }
        VStack(){
            HStack(){
                if (pointTarget.targetpointbool == false){
                Button(action:{ self.targetMenu.toggle()}){
                    Text("\(armyControl.armies[armyControl.armies.count-1].pointCount) pts").foregroundColor(.white)
                    .frame(width: 195, height: 10)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.green)).sheet(isPresented: $targetMenu){
                                if #available(iOS 16.0, *) {
                                    targetPicker().environmentObject(pointTarget).presentationDetents([.medium])
                                } else {
                                    // Fallback on earlier versions
                                    targetPicker().environmentObject(pointTarget)
                                } // вызов меню выбора цели по очкам(в зависимости от версии ios она будет выглядеть по разному из-за нововведений swift)
                            }
                }
            } else {
                if (armyControl.armies[armyControl.armies.count-1].pointCount > pointTarget.count){
                Button(action:{ self.targetMenu.toggle()}){
                Text("\(armyControl.armies[armyControl.armies.count-1].pointCount) pts / \(pointTarget.count) pts ").foregroundColor(.white)
                .frame(width: 195, height: 10)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(.red)).sheet(isPresented: $targetMenu){
                            if #available(iOS 16.0, *) {
                                targetPicker().environmentObject(pointTarget).presentationDetents([.medium])
                            } else {
                                // Fallback on earlier versions
                                targetPicker().environmentObject(pointTarget)
                            } // вызов меню выбора цели по очкам(в зависимости от версии ios она будет выглядеть по разному из-за нововведений swift)
                        }
            }
                } else {
                    Button(action:{ self.targetMenu.toggle()}){
                        Text("\(armyControl.armies[armyControl.armies.count-1].pointCount) pts / \(pointTarget.count) pts ").foregroundColor(.white)
                    .frame(width: 195, height: 10)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.green)).sheet(isPresented: $targetMenu){
                                if #available(iOS 16.0, *) {
                                    targetPicker().environmentObject(pointTarget).presentationDetents([.medium])
                                } else {
                                    // Fallback on earlier versions
                                    targetPicker().environmentObject(pointTarget)
                                } // вызов меню выбора цели по очкам(в зависимости от версии ios она будет выглядеть по разному из-за нововведений swift)
                            }
                }
                    
                }
            }
            }.padding()
            if(collectionShowcase == false){ // if для того показывать ли юниты которые есть в коллекции
            ScrollView(.vertical){
            VStack(alignment: .center){
                HStack{
                Text("Troops:").font(.title)
                    .fontWeight(.bold)
                    Spacer()
                }.padding()
                ForEach(searchResults){unit in
                    ZStack(){
                        troopCountSelect(unitcount: 0, unitname: unit.name, pointcount: unit.pts, unit: unit, faction: factionfile).environmentObject(pointTarget).environmentObject(armyControl)
                    }
                }.searchable(text: $searchText)
                }
            }
            } else if(collectionHidden == false){
                ScrollView(.vertical){
                    VStack(){
                        HStack{
                        Text("In your collection:")
                            .font(.title)
                            .fontWeight(.bold)
                            Spacer()
                            Button(action:{
                                self.collectionHidden.toggle()
                            }){
                                Image(systemName: "minus")
                            }
                        }.padding()
                        VStack(alignment: .center){
                            ForEach(
                                collectionDatas.getUnits(factionID: factionfile)
                            ){unit in
                                    troopCollectionCount(unitcount: armyControl.armies[armyControl.armies.count-1].troops[unit.unitid] ?? 999, unitname: globalstats[factionfile].units[unit.unitid-1].name, pointcount: globalstats[factionfile].units[unit.unitid-1].pts, unit: globalstats[factionfile].units[unit.unitid-1], faction: factionfile).environmentObject(pointTarget).environmentObject(armyControl)
                            }
                        }.padding(.vertical)
                    }
                VStack(alignment: .center){
                    HStack{
                    Text("Troops:").font(.title)
                        .fontWeight(.bold)
                        Spacer()
                    }.padding()
                    ForEach(searchResults){unit in
                            troopCountSelect(unitcount: armyControl.armies[armyControl.armies.count-1].troops[unit.id] ?? 999, unitname: unit.name, pointcount: unit.pts, unit: unit, faction: factionfile).environmentObject(pointTarget).environmentObject(armyControl)
                        
                    }.searchable(text: $searchText)
                    }
                }
            } else{
                ScrollView(.vertical){
                    VStack(){
                        HStack{
                        Text("In your collection:")
                            .font(.title)
                            .fontWeight(.bold)
                            Spacer()
                            Button(action:{
                                self.collectionHidden.toggle()
                            }){
                                Image(systemName: "plus")
                            }
                        }.padding()
                    }
                VStack(alignment: .center){
                    HStack{
                    Text("Troops:").font(.title)
                        .fontWeight(.bold)
                        Spacer()
                    }.padding()
                    ForEach(searchResults){unit in
                        ZStack(){
                            troopCountSelect(unitcount: armyControl.armies[armyControl.armies.count-1].troops[unit.id] ?? 999, unitname: unit.name, pointcount: unit.pts, unit: unit, faction: factionfile).environmentObject(pointTarget).environmentObject(armyControl)
                        }
                    }.searchable(text: $searchText)
                    }
                }
            }
        }.navigationTitle("Add a new army!").toolbar{
            ToolbarItemGroup(placement: .primaryAction){
                Button(action:{
                    addArmy(army: armyControl.armies[armyControl.armies.count-1])
                    viewControl.showingaddArmy = false
                }){
                    Text("Done")
                }
            }
        }
        }
    var searchResults: [unit] {
            if searchText.isEmpty {
                return globalstats[factionfile].units
            } else {
                return globalstats[factionfile].units.filter { $0.name.lowercased().contains(searchText.lowercased())}
            }
        }

}
