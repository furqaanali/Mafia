/*
//
//  Testing.swift
//  Mafia3
//
//  Created by Furqaan Ali on 5/22/20.
//  Copyright © 2020 Furqaan Ali. All rights reserved.
//

import SwiftUI

struct Testing: View {
    
    @State private var isNight: Bool = false
    @State private var attacked: Int = 0
    @State private var rescued: Int = 0
    
    private var playerNames = ["Furqaan", "Ayesha", "Farhan", "Aamina"]
    
    var body: some View {
        VStack {
//        Button(action: {self.isNight.toggle()}) {
//            Text("Begin Night")
//        }
//        .sheet(isPresented: self.$isNight) {
            
            NavigationView {
                Form {
                    Section {
                    Text("Who does the Mafia attack?")
                    Picker(selection: self.$attacked, label: Text("")) {
                        ForEach(0 ..< self.playerNames.count) {
                            Text(self.playerNames[$0])
                       }
                    }
                    }
                }
            }
            NavigationView {
                Form {
                    Section {
                    Text("Who does the Doctor Rescue?")
                    Picker(selection: self.$rescued, label: Text("")) {
                        ForEach(0 ..< self.playerNames.count) {
                            Text(self.playerNames[$0])
                       }
                    }
                    }
                }
            }
            
            Form {
            Text("Attacked: \(self.attacked)")
            Text("Rescued: \(self.rescued)")
            }
//        }
        }
    }
}

struct Testing_Previews: PreviewProvider {
    static var previews: some View {
        Testing()
    }
}
*/


//
//  PlayerRow.swift
//  Mafia3
//
//  Created by Furqaan Ali on 5/22/20.
//  Copyright © 2020 Furqaan Ali. All rights reserved.
//

/*
import SwiftUI

struct PlayerRow: View {
    
    var playerNames = ["Ayesha", "Farhan", "Furqaan", "Aamina"]
    var roles = ["Civilian", "Mafia", "Civilian", "Doctor"]
    
    var index: Int
    
    var body: some View {
        HStack {
            Image(roles[index])
            .resizable()
            .frame(width: 50, height: 50)
//            .clipShape(Circle())
//            .overlay(
//                Circle().stroke(Color.white, lineWidth: 4))
//            .shadow(radius: 10)
            Text(playerNames[index])
            Text(roles[index])
            Spacer()
        }
    }
}

struct PlayerRow_Previews: PreviewProvider {
    static var previews: some View {
        PlayerRow(index: 0)
    }
}
*/

import SwiftUI

struct Testing: View {
    
    @State private var myDictKeys = ["Mafia", "Doctor", "Killer", "Joker"]
    @State private var myDictVals = [-1, -1, -1, -1]
    @State var mylist = [ "jack", "joe" , "ben"]
    @State var temp = [-1]
    
    @State var playerNames = ["Ayesha", "Farhan", "Furqaan", "Aamina"]
    @State var lover = ""

    var body: some View {
        VStack {
            List {
                ForEach(self.playerNames, id: \.self) { player in
                    SelectionRow(title: player, isSelected: self.playerNames[0] == player) {
                        if self.lover.contains(player) {
                            self.lover.removeAll()
                        }
                        else {
                            self.lover.removeAll()
                            self.lover.append(player)
                        }
                    }
                }
            }
//            ForEach(myDictKeys.indices, id: \.self) { index in
//                NavigationView {
//                    Form {
//                        Text("Who does \(self.myDictKeys[index]) choose?")
//                        Picker(selection: self.$myDictVals[index], label: Text("hi")) {
//                            ForEach(0 ..< self.mylist.count) {
//                                Text(self.mylist[$0])
//                           }
//                        }
//                    }
////                    .frame(height: 200.0)
//                }
//            }
//            Form {
//                ForEach(myDictKeys.indices, id: \.self) {index in
//                    Group {
//                        if self.myDictVals[index] >= 0 {
//                            Text(self.mylist[self.myDictVals[index]])
//                        }
//                    }
//                }
//            }
//            HStack {
//                Text("Hello")
//                Text("Civilian")
//                    .font(.caption)
//                    .fontWeight(.light)
//                    .foregroundColor(Color.pink)
//
//                Spacer()
//            }
//            List {
//            Group {
//                ForEach(myDict.sorted(by: >), id: \.key) { key, value in
//                    NavigationView {
//                        Form {
//                            Text("Who does \(key) choose?")
//                            Picker(selection: self.$myDict["Mafia"], label: Text("hi")) {
//                                ForEach(0 ..< self.mylist.count) {
//                                    Text(self.mylist[$0])
//                               }
//                            }
//                        }
//                    }
//                }
//            }
//            Group {
//            ForEach(myDict.sorted(by: >), id: \.key) { key, value in
//                Group {
//                    if value >= 0 {
//                        Text("Attacked: \(value)")
//                    }
//                }
////            }
//            }
//            Text(String(myDict.))
//            Text(String(self.myDict["Doctor"]!))
//            Text(String(self.myDict["Killer"]!))
//            }
        }
    }
}

struct Testing_Previews: PreviewProvider {
    static var previews: some View {
        Testing()
    }
}
